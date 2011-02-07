Return-Path: <tmarri@apm.com>
Received: from exprod5og112.obsmtp.com (exprod5og112.obsmtp.com [64.18.0.24])
	by ozlabs.org (Postfix) with SMTP id 18EE6B6EE9
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  8 Feb 2011 05:53:29 +1100 (EST)
Received: by vxb40 with SMTP id 40so1694770vxb.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 07 Feb 2011 10:53:27 -0800 (PST)
From: Tirumala Marri <tmarri@apm.com>
References: <1295477852-14735-1-git-send-email-tmarri@apm.com>
	<20110126191734.5dff9641@desktopvm.lvknet>
In-Reply-To: <20110126191734.5dff9641@desktopvm.lvknet>
MIME-Version: 1.0
Date: Mon, 7 Feb 2011 10:53:25 -0800
Message-ID: <4d3a1de3bf1ff8a4f69bf2d90da0a1cf@mail.gmail.com>
Subject: RE: [PATCH V8 03/10] USB/ppc4xx: Add Synopsys DWC OTG Core Interface
	Layer
To: Alexander Gordeev <lasaine@lvk.cs.msu.su>
Content-Type: text/plain; charset=ISO-8859-1
Cc: greg@kroah.com, linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	Fushen Chen <fchen@apm.com>, Mark Miesfeld <mmiesfeld@apm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

dwc_read_reg32 is used nowhere throughout the code. One of dwc_read32 and
dwc_read_reg32 should be removed IMO. There was once only dwc_read_reg32. In
version 5 of your patchset I believe. Why did you add another function?
AFAIK it is not correct to store pointers in u32 because they need 8 bytes
on 64-bit archs. So it was ok with the old dwc_read_reg32.
[Marri] If u32 is 8bytes isn't pointer type would be 8bytes as well. I had
change the API to avoid type castings to register addresses.
