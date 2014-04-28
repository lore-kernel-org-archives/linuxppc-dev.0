Return-Path: <benh@au1.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 105381400A6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Apr 2014 19:18:17 +1000 (EST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <benh@au1.ibm.com>;
 Mon, 28 Apr 2014 19:17:50 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id E8C992BB004A
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Apr 2014 19:17:45 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s3S8ubSw66650264
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Apr 2014 18:56:37 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s3S9Hij8002595
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Apr 2014 19:17:44 +1000
Message-ID: <1398676654.30694.39.camel@pasglop>
Subject: Re: [RFC PATCH] Fix Oops in rtas_stop_self()
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
To: David Laight <David.Laight@aculab.com>
Date: Mon, 28 Apr 2014 19:17:34 +1000
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6D0F700501@AcuExch.aculab.com>
References: <1398418381.2805.168.camel@ThinkPad-T5421.cn.ibm.com>
 <20140425221833.3cc04b0c@kryten> <1398644805.3046.7.camel@ThinkPad-T5421>
 <063D6719AE5E284EB5DD2968C1650D6D0F700501@AcuExch.aculab.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: PowerPC email list <linuxppc-dev@lists.ozlabs.org>,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 'Li Zhong' <zhong@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2014-04-28 at 09:06 +0000, David Laight wrote:
> > Ah, yes, the stack here is obviously at a much higher address than
> 4GB.
> 
> Are we talking of physical or virtual addresses here?
> (or even user?)

Real.

> Is there a re-entrancy problem using kernel static data?

Not for this code. This is called as the last thing a CPU does
before returning to firmware.

Cheers,
Ben.
