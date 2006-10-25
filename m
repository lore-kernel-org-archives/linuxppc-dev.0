Return-Path: <luong.ngo@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.183])
	by ozlabs.org (Postfix) with ESMTP id 4F58267BE1
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Oct 2006 17:23:05 +1000 (EST)
Received: by py-out-1112.google.com with SMTP id f25so55254pyf
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Oct 2006 00:23:04 -0700 (PDT)
Message-ID: <1b2aacd80610250016q4bcc5f9bm467ef09022ce1285@mail.gmail.com>
Date: Wed, 25 Oct 2006 00:16:41 -0700
From: "Luong Ngo" <luong.ngo@gmail.com>
To: "Kumar Gala" <galak@kernel.crashing.org>
Subject: Re: MPC8343: PCI resource allocation questions
In-Reply-To: <4BF669F6-7A28-4915-9DFF-0B00CC04E242@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_105401_22840958.1161760601233"
References: <1b2aacd80610242049j23917f61x1e277b4c6a581f9a@mail.gmail.com>
	<E2847437-6C75-4963-B9DB-BAC050015C88@kernel.crashing.org>
	<1b2aacd80610242246n20075a33pcc76ab5be71fb87e@mail.gmail.com>
	<4BF669F6-7A28-4915-9DFF-0B00CC04E242@kernel.crashing.org>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

------=_Part_105401_22840958.1161760601233
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Would you mind explain me the last question in previous email?

  You are not leaving any memory space for any of the onchip devices,
the error messages are because the regions of memory that the devices
are expected to be at are already occupied by the PCI space.

Isn't it the PCI IO and PCI MEM space are separated from local memory space?
I think I see the global IO resource and MEM resource have the range of 0x0
- 0xFFFFFFFF.

Thanks,
Luong Ngo

On 10/24/06, Kumar Gala <galak@kernel.crashing.org> wrote:
>
>
> > I'm a bit confused here. If the host bridge is ignored/excluded,
> > then the region size in BARs will not be allocated corresponding
> > resource by the PCI subsystem, then how would other PCI devices in
> > the slots could be allocated in the BAR's range? If I understand
> > correctly, the PCI devices's resources are allocated based on the
> > bridge resource, which is assigned statically by PCI subsystem
> > using hose->mem_space and hose->io_space instead of reading it from
> > the BARs. Maybe you are saying in the case the CPU is in agent mode
> > and its PCI host bridge is functioning as a PCI-PCI bridge?
>
> The problem is the host bridge shouldn't be included in BAR
> assignment since its the host bridge.  The problem is FSL devices
> show up when they scan themselves and the kernel then tries to
> allocate resources to them as if they were any other device.
>
> you are correct, the pci subsystem is setup via the hose structure
> and not by trying to read BARs on the host controller itself.
>
> - kumar
>

------=_Part_105401_22840958.1161760601233
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div><br>Would you mind explain me the last question in previous email?</div>
<div>&nbsp;</div>
<div><span class="q">&nbsp; 
<div>You are not leaving any memory space for any of the onchip devices,<br>the error messages are because the regions of memory that the devices<br>are expected to be at are already occupied by the PCI space.<br>&nbsp;</div>
</span>
<div><font style="BACKGROUND-COLOR: #ffffff" color="#3366ff">Isn't it the PCI IO and PCI MEM space are separated from local memory space? I&nbsp;think I see the global IO resource and MEM resource have the range of 0x0 - 0xFFFFFFFF.
</font> </div></div>
<div>&nbsp;</div>
<div>Thanks,</div>
<div>Luong Ngo<br>&nbsp;</div>
<div><span class="gmail_quote">On 10/24/06, <b class="gmail_sendername">Kumar Gala</b> &lt;<a href="mailto:galak@kernel.crashing.org">galak@kernel.crashing.org</a>&gt; wrote:</span>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid"><br>&gt; I'm a bit confused here. If the host bridge is ignored/excluded,<br>&gt; then the region size in BARs will not be allocated corresponding
<br>&gt; resource by the PCI subsystem, then how would other PCI devices in<br>&gt; the slots could be allocated in the BAR's range? If I understand<br>&gt; correctly, the PCI devices's resources are allocated based on the
<br>&gt; bridge resource, which is assigned statically by PCI subsystem<br>&gt; using hose-&gt;mem_space and hose-&gt;io_space instead of reading it from<br>&gt; the BARs. Maybe you are saying in the case the CPU is in agent mode
<br>&gt; and its PCI host bridge is functioning as a PCI-PCI bridge?<br><br>The problem is the host bridge shouldn't be included in BAR<br>assignment since its the host bridge.&nbsp;&nbsp;The problem is FSL devices<br>show up when they scan themselves and the kernel then tries to
<br>allocate resources to them as if they were any other device.<br><br>you are correct, the pci subsystem is setup via the hose structure<br>and not by trying to read BARs on the host controller itself.<br><br>- kumar<br>
</blockquote></div><br>

------=_Part_105401_22840958.1161760601233--
