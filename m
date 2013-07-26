Return-Path: <nhorman@tuxdriver.com>
Received: from smtp.tuxdriver.com
 (tuxdriver-1-pt.tunnel.tserv13.ash1.ipv6.he.net [IPv6:2001:470:7:9c9::2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 21DD52C00D8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Jul 2013 23:11:45 +1000 (EST)
Date: Fri, 26 Jul 2013 09:11:14 -0400
From: Neil Horman <nhorman@tuxdriver.com>
To: Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH] module: ppc64 module CRC relocation fix causes perf issues
Message-ID: <20130726131114.GA11633@hmsreliant.think-freely.org>
References: <20130718140045.6794ecd5@kryten> <1374274770.5357.33@snotra>
 <20130725083427.56e36010@kryten> <1374707665.6142.18.camel@pasglop>
 <20130725130212.GA19366@hmsreliant.think-freely.org>
 <20130726111913.201ab9d4@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130726111913.201ab9d4@kryten>
Cc: Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, Scott Wood <scottwood@freescale.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jul 26, 2013 at 11:19:13AM +1000, Anton Blanchard wrote:
> 
> Hi Neil,
> 
> > Sorry I'm a bit late to the thread, I've ben swamped.  Has someone
> > tested this with kexec/kdump?  Thats why the origional patch was
> > created, because when kexec loads the kernel at a different physical
> > address, the relocations messed with the module crc's, and modules
> > couldn't load during the kexec boot.  Assuming that kernaddr_start
> > gets set appropriately during boot, using PHYSICAL_START should be
> > fine, but I wanted to check, and don't currently have access to a
> > powerpc system to do so. Neil
> 
> I tested a relocatable kernel forced to run at a non zero physical
> address (ie basically kdump). I verified CRCs were bad with your
> original patch backed out, and were good with this patch applied.
> 
> Anton
> 

Perfect, sounds like a sufficient test to me.

Acked-by: Neil Horman <nhorman@tuxdriver.com>
