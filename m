Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CC6D81A02E5
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Mar 2015 10:52:34 +1100 (AEDT)
Message-ID: <1425513154.32154.12.camel@ellerman.id.au>
Subject: Re: Problems with Kernels 3.17-rc1 and onwards on Acube Sam460 AMCC
 460ex board
From: Michael Ellerman <mpe@ellerman.id.au>
To: Julian Margetson <runaway@candw.ms>
Date: Thu, 05 Mar 2015 10:52:34 +1100
In-Reply-To: <54F6F081.9060007@candw.ms>
References: <54E08E06.8060607@candw.ms>
 <1424045921.3018.4.camel@ellerman.id.au> <54E4EBD7.5000307@candw.ms>
 <1424304787.22020.4.camel@ellerman.id.au> <54E53E07.60609@candw.ms>
 <1424314594.22408.1.camel@ellerman.id.au> <54E55796.6000401@candw.ms>
 <54E78A12.7080409@candw.ms> <1424737962.2318.2.camel@ellerman.id.au>
 <45dfe45093f.4ef2935f@smtp.gmail.com> <54ECCD8A.3060708@gmx.net>
 <54ECDE7D.6070303@candw.ms> <54EDCD9E.5010104@candw.ms>
 <54F6F081.9060007@candw.ms>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-03-04 at 07:46 -0400, Julian Margetson wrote:
> Still stuck.
> Problem still exist with 4.0.0-rc2 and I cant finish the bisect.
> Triggered when using HDMI. No problem when using DVI.

> [   33.535692] Unable to handle kernel paging request for data at address 0x00000008
> [   33.566786] Faulting instruction address: 0xc049db84
> [   33.574188] Vector: 300 (Data Access) at [eeb13c20]
> [   33.579086]     pc: c049db84: radeon_audio_enable+0x4/0x18
> [   33.584630]     lr: c049e2f4: radeon_audio_detect+0x288/0x290
> [   33.590429]     sp: eeb13cd0
> [   33.593310]    msr: 29000
> [   33.595931]    dar: 8
> [   33.598207]  dsisr: 0
> [   33.600480]   current = 0xeea93ac0
> [   33.603885]     pid   = 2311, comm = Xorg
> [   33.607922] enter ? for help
> [   33.610806] [link register   ] c049e2f4 radeon_audio_detect+0x288/0x290
> [   33.617469] [eeb13cd0] c049e254 radeon_audio_detect+0x1e8/0x290 (unreliable)
> [   33.624571] [eeb13d00] c03dfe7c radeon_dvi_detect+0x388/0x3ac
> [   33.630369] [eeb13d30] c038b9d4 drm_helper_probe_single_connector_modes_merge_bits+0xf4/0x434
> [   33.638954] [eeb13d70] c03a7670 drm_mode_getconnector+0xf4/0x334
> [   33.645022] [eeb13e10] c039a8c0 drm_ioctl+0x348/0x464
> [   33.650135] [eeb13ed0] c00d0ca0 do_vfs_ioctl+0x52c/0x6e8
> [   33.655507] [eeb13f20] c00d0e9c SyS_ioctl+0x40/0x68
> [   33.660438] [eeb13f40] c000ab04 ret_from_syscall+0x0/0x3c
> [   33.665896] --- Exception: c01 (System Call) at 6fb1b8dc
> [   33.671253] SP (bfa56d20) is in userspace
> [   33.675263] mon>  <no input ...>

This just looks like a missing NULL check in the radeon code. Probably here:

void radeon_audio_detect(struct drm_connector *connector,
	enum drm_connector_status status)
{
	struct radeon_device *rdev;
	struct radeon_encoder *radeon_encoder;
	struct radeon_encoder_atom_dig *dig;

	if (!connector || !connector->encoder)
		return;

	rdev = connector->encoder->dev->dev_private;
	                           ^

So you could try adding "!connector->encoder->dev" to the if there.

cheers
