Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8D64DB6F7B
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  6 Sep 2011 03:17:26 +1000 (EST)
Subject: Re: [PATCH 14/14] arm/include/asm/io.h : added macros to
	read/write big/little endian register
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
In-Reply-To: <20110905142802.GB24469@linutronix.de>
References: <cover.1314704557.git.pratyush.anand@st.com>
	<335243c9467c0127206234819a94c9f72358fdf2.1314704558.git.pratyush.anand@st.com>
	<1314961303.13112.1.camel@pasglop>
	<20110905142802.GB24469@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 06 Sep 2011 03:16:59 +1000
Message-ID: <1315243019.13112.52.camel@pasglop>
Mime-Version: 1.0
Cc: Pratyush Anand <pratyush.anand@st.com>, viresh.kumar@st.com,
	vipulkumar.samar@st.com, bhupesh.sharma@st.com, tmarri@apm.com,
	linux-usb@vger.kernel.org, vipin.kumar@st.com,
	shiraz.hashim@st.com, Amit.VIRDI@st.com, rajeev-dlh.kumar@st.com,
	mmiesfeld@apm.com, deepak.sikri@st.com,
	linuxppc-dev@lists.ozlabs.org, fchen@apm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2011-09-05 at 16:28 +0200, Sebastian Andrzej Siewior wrote:
> * Benjamin Herrenschmidt | 2011-09-02 21:01:43 [+1000]:
> 
> >or better, switch to the newer iomap variants which should be
> >provided in both endianness.
> 
> I know some ppc-mmu provide the capability to perform the endian swap
> during page access. I wasn't aware that there is a kernel wide interface
> for this. What do you do on architectures which don't provide this?

Oh we don't provide a kernel interface for it, well not "officially",
that's not what I meant by using iomap.

You -can- use the platform specific _PAGE_ENDIAN to ioremap_flags() but
that's very platform specific and it's up to you to know you're doing it
on a CPU that supports it :-)

Cheers,
Ben.
