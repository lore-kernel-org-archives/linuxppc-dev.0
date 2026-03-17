Return-Path: <linuxppc-dev+bounces-18321-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4492FD877B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Mar 2026 14:31:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZvXL5xVsz2yh4;
	Wed, 18 Mar 2026 01:31:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=37.157.195.192
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773757874;
	cv=none; b=j3aSqPoijYpePzX2qky/SM39UNuaDfTRTI8nzdH+VoTh5ju+drxwZeWvgcv0naji9fyDKHwKQ9dpPQ7nZtR+vOC5nhwon4aw9lJc3nIWqr+R+BjHCPqFHCpLjVfS8c9t4kGoAnSaaWO/Ls8B8oe21+/gPChNeNwJbfio5cvXV/yt5NsQL84wggvggFQUPVglziEjrJ9JKgnG5Kv2PPx26p/Hw1lnfVJFcpxyx99KyOIxTjkxP1rlCi4QQuNiGn1ORVr1WSTjjaZlk/HxvP/qes+KfwU/QCKgT7WA624c8QbJqDN1w0+dRcEcV7aPSnurdI0t2OJlLdZk2ERkxCgIbw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773757874; c=relaxed/relaxed;
	bh=VSYZo/uxUYak4QqWko4Nw7QCsNj3OoQLFcgEeOB5IWA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=fhrE6DE7d3FkMindbR7WpvhiVkKS2IOZY80dc+EawBGZlYFx9vjoOiiQbhhisXO6BhJMYE6a9QxxtGmGDDl50osZYtESY2ZsvPqlTBr2sdSQQPVw6aG1EpNOxqja7p+U279lmBDUIgAs2zLIPYRK13GCOxI/Kmdj403SMGw6End98yXK+XSN7ibCYm6wSAv/NWriy+SFHHcfWuCEgxtyGCheJRHZSYcA+jRbGnBm6m7yKUj70T8qFbrSvZN4VPEzO8wTgYi8we9zfMzze+JOv3yIZGTLfbwgA3bIBhkUQeEJAeencmVzg3svr2F+8fwANNMEuXhNmkxoCg369Tuvtw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=danny.cz; spf=pass (client-ip=37.157.195.192; helo=redcrew.org; envelope-from=dan@danny.cz; receiver=lists.ozlabs.org) smtp.mailfrom=danny.cz
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=danny.cz
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=danny.cz (client-ip=37.157.195.192; helo=redcrew.org; envelope-from=dan@danny.cz; receiver=lists.ozlabs.org)
Received: from redcrew.org (redcrew.org [37.157.195.192])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZvXJ1Gwkz2ySq
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Mar 2026 01:31:10 +1100 (AEDT)
Received: from server.danny.cz (85-71-161-19.rce.o2.cz [85.71.161.19])
	by redcrew.org (Postfix) with ESMTP id D2BA5D4;
	Tue, 17 Mar 2026 15:31:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 redcrew.org D2BA5D4
Received: from talos.danny.cz (talos [IPv6:2001:470:5c11:160:47df:83f6:718e:218])
	by server.danny.cz (Postfix) with SMTP id 9BE0A16A001;
	Tue, 17 Mar 2026 15:31:05 +0100 (CET)
Date: Tue, 17 Mar 2026 15:31:05 +0100
From: Dan =?UTF-8?B?SG9yw6Fr?= <dan@danny.cz>
To: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, Gaurav Batra <gbatra@linux.ibm.com>,
 amd-gfx@lists.freedesktop.org, Donet Tom <donettom@linux.ibm.com>
Subject: Re: amdgpu driver fails to initialize on ppc64le in 7.0-rc1 and
 newer
Message-Id: <20260317153105.99c2618bdfd3f8c49c0c2779@danny.cz>
In-Reply-To: <ms06y93w.ritesh.list@gmail.com>
References: <20260313142351.609bc4c3efe1184f64ca5f44@danny.cz>
	<1phlu3bs.ritesh.list@gmail.com>
	<20260315105021.667e52d4a99b154ef1e6aa34@danny.cz>
	<ms06y93w.ritesh.list@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; powerpc64le-redhat-linux-gnu)
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Ritesh,

On Tue, 17 Mar 2026 17:13:31 +0530
Ritesh Harjani (IBM) <ritesh.list@gmail.com> wrote:

> Dan Horák <dan@danny.cz> writes:
> 
> > Hi Ritesh,
> >
> > On Sun, 15 Mar 2026 09:55:11 +0530
> > Ritesh Harjani (IBM) <ritesh.list@gmail.com> wrote:
> >
> >> Dan Horák <dan@danny.cz> writes:
> >> 
> >> +cc Gaurav,
> >> 
> >> > Hi,
> >> >
> >> > starting with 7.0-rc1 (meaning 6.19 is OK) the amdgpu driver fails to
> >> > initialize on my Linux/ppc64le Power9 based system (with Radeon Pro WX4100)
> >> > with the following in the log
> >> >
> >> > ...
> >> > bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: GART: 256M 0x000000FF00000000 - 0x000000FF0FFFFFFF
> >> 
> >>                   ^^^^
> >> So looks like this is a PowerNV (Power9) machine.
> >
> > correct :-)
> >  
> >> > bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: [drm] Detected VRAM RAM=4096M, BAR=4096M
> >> > bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: [drm] RAM width 128bits GDDR5
> >> > bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: iommu: 64-bit OK but direct DMA is limited by 0
> >> > bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: dma_iommu_get_required_mask: returning bypass mask 0xfffffffffffffff
> >> > bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0:  4096M of VRAM memory ready
> >> > bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0:  32570M of GTT memory ready.
> >> > bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: (-12) failed to allocate kernel bo
> >> > bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: [drm] Debug VRAM access will use slowpath MM access
> >> > bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: [drm] GART: num cpu pages 4096, num gpu pages 65536
> >> > bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: [drm] PCIE GART of 256M enabled (table at 0x000000F4FFF80000).
> >> > bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: (-12) failed to allocate kernel bo
> >> > bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: (-12) create WB bo failed
> >> > bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: amdgpu_device_wb_init failed -12
> >> > bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: amdgpu_device_ip_init failed
> >> > bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: Fatal error during GPU init
> >> > bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: finishing device.
> >> > bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: probe with driver amdgpu failed with error -12
> >> > bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0:  ttm finalized
> >> > ...
> >> >
> >> > After some hints from Alex and bisecting and other investigation I have
> >> > found that https://github.com/torvalds/linux/commit/1471c517cf7dae1a6342fb821d8ed501af956dd0
> >> > is the culprit and reverting it makes amdgpu load (and work) again.
> >> 
> >> Thanks for confirming this. Yes, this was recently added [1]
> >> 
> >> [1]: https://lore.kernel.org/linuxppc-dev/20251107161105.85999-1-gbatra@linux.ibm.com/ 
> >> 
> >> 
> >> @Gaurav,
> >> 
> >> I am not too familiar with the area, however looking at the logs shared
> >> by Dan, it looks like we might be always going for dma direct allocation
> >> path and maybe the device doesn't support this address limit. 
> >> 
> >>  bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: iommu: 64-bit OK but direct DMA is limited by 0
> >>  bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: dma_iommu_get_required_mask: returning bypass mask 0xfffffffffffffff
> >
> > a complete kernel log is at
> > https://gitlab.freedesktop.org/-/project/4522/uploads/c4935bca6f37bbd06bb4045c07d00b5b/kernel.log
> >
> > Please let me know if you need more info.
> 
> Hi Dan,
> 
> Thanks for sharing the kernel log. Is it also possible to kindly share
> your full kernel config with which you saw this issue.

the log is from an official Fedora kernel, thus the config is
https://src.fedoraproject.org/rpms/kernel/blob/8477f609d4875a2c20717519243fb2e6fb1cdb8f/f/kernel-ppc64le-fedora.config

and yes, Fedora, like RHEL, uses 64k kernel page size for ppc64le and
except years ago I haven't had a 64k related issue with my card. IIRC
there were page size related issues with the newer (Navi?) cards, but
those also had been solved.

 
> I think Gaurav, is still looking into reported issue. However I was
> interested in this kernel log output..
> 
> bře 05 08:35:34 talos.danny.cz kernel: radix-mmu: Mapped 0x00002007fad00000-0x00002007fcd00000 with 64.0 KiB pages
> 
> This shows that the system is using 64K pagesize. So I was interested in
> knowing the kernel configs you have enabled. Donet has recently posted
> 64K pagesize support with amdgpu [1][2] on Power. However, I think, we
> can still use it w/o Donet's changes if we have CONFIG_HSA_AMD_SVM
> disabled.
> 
> So, can you kindly share the kernel configs and the AMD GPU HW details
> attached to your Power9 baremetal system, if it's possible?

output of "lspci -nn -vvv"

0000:01:00.0 VGA compatible controller [0300]: Advanced Micro Devices, Inc. [AMD/ATI] Baffin [Radeon Pro WX 4100] [1002:67e3] (prog-if 00 [VGA controller])
        Subsystem: Advanced Micro Devices, Inc. [AMD/ATI] Device [1002:0b0d]
        Device tree node: /sys/firmware/devicetree/base/pciex@600c3c0000000/pci@0/vga@0
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Interrupt: pin A routed to IRQ 194
        NUMA node: 0
        IOMMU group: 0
        Region 0: Memory at 6000000000000 (64-bit, prefetchable) [size=4G]
        Region 2: Memory at 6000100000000 (64-bit, prefetchable) [size=2M]
        Region 5: Memory at 600c000000000 (32-bit, non-prefetchable) [size=256K]
        Expansion ROM at 600c000040000 [disabled] [size=128K]
        Capabilities: [48] Vendor Specific Information: Len=08 <?>
        Capabilities: [50] Power Management version 3
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1+,D2+,D3hot+,D3cold+)
                Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [58] Express (v2) Legacy Endpoint, IntMsgNum 0
                DevCap: MaxPayload 256 bytes, PhantFunc 0, Latency L0s <4us, L1 unlimited
                        ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset- TEE-IO-
                DevCtl: CorrErr- NonFatalErr+ FatalErr+ UnsupReq+
                        RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
                        MaxPayload 256 bytes, MaxReadReq 512 bytes
                DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- TransPend-
                LnkCap: Port #0, Speed 8GT/s, Width x8, ASPM L1, Exit Latency L1 <1us
                        ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
                LnkCtl: ASPM Disabled; RCB 64 bytes, LnkDisable- CommClk-
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt- FltModeDis-
                LnkSta: Speed 8GT/s, Width x8
                        TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
                DevCap2: Completion Timeout: Not Supported, TimeoutDis- NROPrPrP- LTR+
                         10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt+ EETLPPrefix+, MaxEETLPPrefixes 1
                         EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
                         FRS-
                         AtomicOpsCap: 32bit+ 64bit+ 128bitCAS-
                DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
                         AtomicOpsCtl: ReqEn-
                         IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
                         10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
                LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink- Retimer- 2Retimers- DRS-
                LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
                         Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
                         Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
                LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete+ EqualizationPhase1+
                         EqualizationPhase2+ EqualizationPhase3+ LinkEqualizationRequest-
                         Retimer- 2Retimers- CrosslinkRes: unsupported, FltMode-
        Capabilities: [a0] MSI: Enable+ Count=1/1 Maskable- 64bit+
                Address: 1000000000000000  Data: 0000
        Capabilities: [100 v1] Vendor Specific Information: ID=0001 Rev=1 Len=010 <?>
        Capabilities: [150 v2] Advanced Error Reporting
                UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP-
                        ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- AtomicOpBlocked- TLPBlockedErr-
                        PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- PCRC_CHECK- TLPXlatBlocked-
                UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP-
                        ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- AtomicOpBlocked- TLPBlockedErr-
                        PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- PCRC_CHECK- TLPXlatBlocked-
                UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+
                        ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- AtomicOpBlocked- TLPBlockedErr-
                        PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- PCRC_CHECK- TLPXlatBlocked-
                CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr- CorrIntErr- HeaderOF-
                CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+ CorrIntErr- HeaderOF-
                AERCap: First Error Pointer: 00, ECRCGenCap+ ECRCGenEn+ ECRCChkCap+ ECRCChkEn+
                        MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
                HeaderLog: 00000000 00000000 00000000 00000000
        Capabilities: [200 v1] Physical Resizable BAR
                BAR 0: current size: 4GB, supported: 256MB 512MB 1GB 2GB 4GB
        Capabilities: [270 v1] Secondary PCI Express
                LnkCtl3: LnkEquIntrruptEn- PerformEqu-
                LaneErrStat: 0
        Capabilities: [2b0 v1] Address Translation Service (ATS)
                ATSCap: Invalidate Queue Depth: 00
                ATSCtl: Enable-, Smallest Translation Unit: 00
        Capabilities: [2c0 v1] Page Request Interface (PRI)
                PRICtl: Enable- Reset-
                PRISta: RF- UPRGI- Stopped+ PASID-
                Page Request Capacity: 00000020, Page Request Allocation: 00000000
        Capabilities: [2d0 v1] Process Address Space ID (PASID)
                PASIDCap: Exec+ Priv+, Max PASID Width: 10
                PASIDCtl: Enable- Exec- Priv-
        Capabilities: [320 v1] Latency Tolerance Reporting
                Max snoop latency: 0ns
                Max no snoop latency: 0ns
        Capabilities: [328 v1] Alternative Routing-ID Interpretation (ARI)
                ARICap: MFVC- ACS-, Next Function: 1
                ARICtl: MFVC- ACS-, Function Group: 0
        Capabilities: [370 v1] L1 PM Substates
                L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates+
                          PortCommonModeRestoreTime=0us PortTPowerOnTime=170us
                L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-
                           T_CommonMode=0us LTR1.2_Threshold=0ns
                L1SubCtl2: T_PwrOn=10us
        Kernel driver in use: amdgpu
        Kernel modules: amdgpu


> [1]: https://lore.kernel.org/amd-gfx/cover.1768223974.git.donettom@linux.ibm.com/#t     #merged
> [2]: https://lore.kernel.org/amd-gfx/cover.1771656655.git.donettom@linux.ibm.com/       #in-review
> 
> -ritesh

if some other is needed, let me know


		Dan

