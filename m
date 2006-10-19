Return-Path: <kallepokki@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.176])
	by ozlabs.org (Postfix) with ESMTP id 20ED067B61
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 20 Oct 2006 05:40:30 +1000 (EST)
Received: by py-out-1112.google.com with SMTP id t32so870897pyc
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 19 Oct 2006 12:40:28 -0700 (PDT)
Message-ID: <a425f86c0610191240q3be8bc87q7f20a345e27a5d3d@mail.gmail.com>
Date: Thu, 19 Oct 2006 22:40:27 +0300
From: "Kalle Pokki" <kalle.pokki@iki.fi>
Sender: kallepokki@gmail.com
To: "Vitaly Bordug" <vbordug@ru.mvista.com>
Subject: Re: [PATCH] CPM_UART: Fix non-console initialisation
In-Reply-To: <20061019231455.0ea159e1@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <Pine.OSF.4.61.0610191525580.318096@kosh.hut.fi>
	<20061019231455.0ea159e1@localhost.localdomain>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 10/19/06, Vitaly Bordug <vbordug@ru.mvista.com> wrote:
> And we end up with init_portdesc called unconditionally? this would likely break, or at least confuse the
> code, that uses platform dev to pass resources offsets.

Well now that I look at it again, we should probably do

if (cpm_uart_no == 0)
     cpm_uart_init_portdesc();

to make it at least a little less confusing. Remember that
init_portdesc() is not called when using platform device, so this
should not affect those targets using it at all.

> Personally, I don't care much of compat stuff, unless it is breaking/confusing targets
> using proper resources...

I'm sure there are still lots of people using the compat mode. As long
as we have it, it should be kept functional.
