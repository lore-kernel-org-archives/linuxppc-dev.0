Return-Path: <bergner@vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DEAC41A00AE
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Nov 2014 04:41:46 +1100 (AEDT)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bergner@vnet.ibm.com>;
 Thu, 27 Nov 2014 10:41:44 -0700
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id BED9219D8026
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Nov 2014 10:30:23 -0700 (MST)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sARHgBOq41746668
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Nov 2014 10:42:11 -0700
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sARHfg6J022919
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Nov 2014 10:41:42 -0700
Subject: Re: [PATCH] powerpc: 32 bit getcpu VDSO function uses 64 bit
 instructions
From: Peter Bergner <bergner@vnet.ibm.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <20141127160829.GA26139@gate.crashing.org>
References: <1417036288-22079-1-git-send-email-anton@samba.org>
 <1417041497.12952.2.camel@concordia> <1417045827.16862.32.camel@otta>
 <20141127160829.GA26139@gate.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 27 Nov 2014 11:41:40 -0600
Message-ID: <1417110100.16862.36.camel@otta>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, Anton Blanchard <anton@samba.org>,
 paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2014-11-27 at 10:08 -0600, Segher Boessenkool wrote:
> On Wed, Nov 26, 2014 at 05:50:27PM -0600, Peter Bergner wrote:
> > Nope, you don't get a SIGILL when executing 64-bit instructions in
> > 32-bit mode, so it'll happily just execute the instruction, doing
> > a full 64-bit compare.  I'm guessing that the upper 32-bits of both
> > r3 and r4 contain zeros, so we're probably just getting lucky.
> 
> You will get a SIGILL if you run on 32-bit hardware.

Ha, I completely forgot about 32-bit hardware.  Anyway, I looked
at the ISA, and cmpdi and cmpwi are just extended mnemonics for
cmpi, with cmpdi setting the L field to 1.  Probably on 32-bit
hardware, the hardware is just ignoring the L bit being set and
doing a cmpwi for us???

Peter
