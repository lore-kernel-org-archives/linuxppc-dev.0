Return-Path: <James.Yang@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe003.messaging.microsoft.com [216.32.180.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id EC85B2C0096
 for <linuxppc-dev@ozlabs.org>; Thu, 14 Nov 2013 04:20:30 +1100 (EST)
Date: Wed, 13 Nov 2013 11:20:19 -0600
From: James Yang <James.Yang@freescale.com>
To: pegasus <aijazbaig1.new@gmail.com>
Subject: Re: BookE "branch taken" behavior vis-a-vis updating the NIP register
In-Reply-To: <1384241835150-78036.post@n7.nabble.com>
Message-ID: <alpine.LRH.2.00.1311131100260.25664@ra8135-ec1.am.freescale.net>
References: <1383907583944-77960.post@n7.nabble.com>
 <alpine.LRH.2.00.1311101509570.9815@ra8135-ec1.am.freescale.net>
 <1384156293077-78004.post@n7.nabble.com>
 <alpine.LRH.2.00.1311111312390.25474@ra8135-ec1.am.freescale.net>
 <1384241835150-78036.post@n7.nabble.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 12 Nov 2013, pegasus wrote:

> So, off I went and downloaded the latest version of 
> arch/powerpc/kernel/traps.c hoping to see those very changes in 
> them. However it didn't match one on one with what was written in 
> that thread. Ditto for the other files in your patch. Looks like 
> your patch didn't make it to upstream but it looks exactly like what 
> I need here. 

The patches were posted RFC -- request for comment.  Thank you for 
posting your comments.


>  So requesting PTRACE_CONT has to happen inside the SIGTRAP signal 
> handler right? 

After you get the SIGTRAP from the branch, yeah.


> Now as for the second patch, as far as I can see, implements the 
> same functionality. However it makes the change permanent and any 
> tool which is used to the NIP pointing to the branch target will be 
> broken.

The second patch places the burden of determining if you are BookE or 
server on the tool.  I feel this is important because the Server and 
Book-E branch exceptions are fundamentally incompatible, and the 
behavior of PTRACE_SINGLEBLOCK can not be made to be identical by the 
kernel for both subarch, so a tool will have to adjust accordingly.


> Anyways, for me either of them will work. But I think the first patch makes
> everyone happy by using the 'addr' field of ptrace. This also means I will
> have to make my (broken) ptrace working which, it seems is not as easy
> adding an enum field as you suggested. May be theres a check somewhere in
> the actual ptrace code which checks for illegal values and hence even after
> adding an enum, it is being reported as illegal in my case. However getting
> that to work is another story.

Actually, I provided the first patch to show why it probably should 
not be done even though technically possible, since it requires ptrace 
API to be extended to now recognize addr field, needs a TIF flag, etc.  
The second patch seems to me more reasonable to support, since nobody 
has come forth to say that there are actually any tools that rely upon 
the existing hack for BookE or even PTRACE_SINGLEBLOCK.  And the 
existing hack's behavior makes things somewhat useless on BookE, as 
you and I have confirmed.

 
> Please confirm my understanding of your patches and since these 
> patches have not made their way to the upstream kernel, will have to 
> use them myself directly. By the way, I'm using 2.6.32.10 (you 
> know..the long-term kernel) and I couldn't find any of your changes 
> in them but then again I couldn't find it in the latest 3.12 version 
> either.


You will have to backport the patches to your kernel if you want to 
use them.  Both patches change the behavior of existing API, and I 
guess we are still waiting to hear if anyone cares which way it should 
be fixed.
