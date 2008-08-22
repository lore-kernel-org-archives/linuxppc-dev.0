Return-Path: <vbendeb@gmail.com>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.29])
	by ozlabs.org (Postfix) with ESMTP id 56B2ADE0DF
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 22 Aug 2008 15:14:17 +1000 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so175888yxg.39
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 21 Aug 2008 22:14:16 -0700 (PDT)
Message-ID: <f608b67d0808212214p3c3e008fxa5418d108b7205f5@mail.gmail.com>
Date: Thu, 21 Aug 2008 22:14:15 -0700
From: vb <vb@vsbe.com>
Sender: vbendeb@gmail.com
To: linuxppc-embedded@ozlabs.org
Subject: Re: TLB programming in powerpc tree. Was: Accessing peripheral bus
	devices on 460GT
In-Reply-To: <f608b67d0808211929g3ae2cf7dm2ba2d65b0043d306@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <f608b67d0808211929g3ae2cf7dm2ba2d65b0043d306@mail.gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, Aug 21, 2008 at 7:29 PM, vb <vb@vsbe.com> wrote:
>
> But the main problem is that the kernel never sets up TLBs for neither
> the peripheral device, nor the onboard flash. I don't seem to be able
> to find the place where this is supposed to happen. I assumed that
> ioremap_nocache would take care of that, but this is not the case.
>

well, in fact the TLB is set up as soon as an attempt to access the
peripheral is made. The problem apparently is the fact that the TLB
entry uses a wrong value in the nibble specifying the internal 460GT
block...
