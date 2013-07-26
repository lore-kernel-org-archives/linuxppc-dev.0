Return-Path: <anton@samba.org>
Date: Fri, 26 Jul 2013 11:19:13 +1000
From: Anton Blanchard <anton@samba.org>
To: Neil Horman <nhorman@tuxdriver.com>
Subject: Re: [PATCH] module: ppc64 module CRC relocation fix causes perf issues
Message-ID: <20130726111913.201ab9d4@kryten>
In-Reply-To: <20130725130212.GA19366@hmsreliant.think-freely.org>
References: <20130718140045.6794ecd5@kryten> <1374274770.5357.33@snotra>
 <20130725083427.56e36010@kryten> <1374707665.6142.18.camel@pasglop>
 <20130725130212.GA19366@hmsreliant.think-freely.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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


Hi Neil,

> Sorry I'm a bit late to the thread, I've ben swamped.  Has someone
> tested this with kexec/kdump?  Thats why the origional patch was
> created, because when kexec loads the kernel at a different physical
> address, the relocations messed with the module crc's, and modules
> couldn't load during the kexec boot.  Assuming that kernaddr_start
> gets set appropriately during boot, using PHYSICAL_START should be
> fine, but I wanted to check, and don't currently have access to a
> powerpc system to do so. Neil

I tested a relocatable kernel forced to run at a non zero physical
address (ie basically kdump). I verified CRCs were bad with your
original patch backed out, and were good with this patch applied.

Anton
