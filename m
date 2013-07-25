Return-Path: <nhorman@tuxdriver.com>
Received: from smtp.tuxdriver.com
 (tuxdriver-1-pt.tunnel.tserv13.ash1.ipv6.he.net [IPv6:2001:470:7:9c9::2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id EB4AB2C00BA
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jul 2013 23:24:25 +1000 (EST)
Date: Thu, 25 Jul 2013 09:02:12 -0400
From: Neil Horman <nhorman@tuxdriver.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] module: ppc64 module CRC relocation fix causes perf issues
Message-ID: <20130725130212.GA19366@hmsreliant.think-freely.org>
References: <20130718140045.6794ecd5@kryten> <1374274770.5357.33@snotra>
 <20130725083427.56e36010@kryten> <1374707665.6142.18.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1374707665.6142.18.camel@pasglop>
Cc: Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 Scott Wood <scottwood@freescale.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jul 25, 2013 at 09:14:25AM +1000, Benjamin Herrenschmidt wrote:
> On Thu, 2013-07-25 at 08:34 +1000, Anton Blanchard wrote:
> > > Apart from the annoying colors, is there anything specific I should
> > > be looking for?  Some sort of error message, or output that actually
> > > makes sense?
> > 
> > Thanks for testing! Ben, I think the patch is good to go.
> 
> Sent it yesterday to Linus, it's upstream already :-)
> 
> Cheers,
> Ben.
> 
Sorry I'm a bit late to the thread, I've ben swamped.  Has someone tested this
with kexec/kdump?  Thats why the origional patch was created, because when kexec
loads the kernel at a different physical address, the relocations messed with
the module crc's, and modules couldn't load during the kexec boot.  Assuming
that kernaddr_start gets set appropriately during boot, using PHYSICAL_START
should be fine, but I wanted to check, and don't currently have access to a
powerpc system to do so.
Neil

> 
> 
> 
