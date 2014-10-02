Return-Path: <segher@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DC75D1A0A42
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Oct 2014 00:18:09 +1000 (EST)
Date: Thu, 2 Oct 2014 09:17:55 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH v2] powerpc: Speed up clear_page by unrolling it
Message-ID: <20141002141755.GA13453@gate.crashing.org>
References: <20141002154421.62073027@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20141002154421.62073027@kryten>
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Oct 02, 2014 at 03:44:21PM +1000, Anton Blanchard wrote:
> This assumes cacheline sizes won't grow beyond 512 bytes or
> page sizes wont drop below 1kB,

Or a combination of those.

> Michael found that some versions of gcc produce quite bad code
> (all multiplies), so we give gcc a hand by using shifts and adds.

You can make the code a lot less cluttered as well as making the
generated code independent of compiler version by writing the setup
of twox..eightx in the asm block itself.


Segher
