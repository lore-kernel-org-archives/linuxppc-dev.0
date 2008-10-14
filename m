Return-Path: <afleming@gmail.com>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.169])
	by ozlabs.org (Postfix) with ESMTP id AFAEFDDE04
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 15 Oct 2008 09:38:06 +1100 (EST)
Received: by wf-out-1314.google.com with SMTP id 24so2504985wfg.15
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 14 Oct 2008 15:38:05 -0700 (PDT)
Message-ID: <2acbd3e40810141538w3781fa4r75cfbe2833a21f81@mail.gmail.com>
Date: Tue, 14 Oct 2008 17:38:05 -0500
From: "Andy Fleming" <afleming@gmail.com>
To: Pieter <phenning@vastech.co.za>
Subject: Re: networking fails to activate
In-Reply-To: <48F450CD.8060309@vastech.co.za>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <48F450CD.8060309@vastech.co.za>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, Oct 14, 2008 at 2:57 AM, Pieter <phenning@vastech.co.za> wrote:
> Hi
>
> We have a powerpc (8548) based board. running eldk4.1. the board has
> three ethernet ports using Gainfair ethernet controller v1.2.
>
> If the board powers up with any network cable plugged in, that specific
> network is accessible.
> if the board powers up without network cables connected and a cable is
> plugged in, the network does not become active.
> The kernal makes a log entry stating that the phy is up when the cable
> is plugged in - but the interface is not pingable
> Running ifdown and ifup manually does not result in a pingable interface.
> Neither does running /etc/init.d/network restart
>
> can anyone help me pls.


Check the statistics counters to see if you are getting any bad
packets, or to see if you are getting interrupts.  Several people have
reported that their PHYs have powerdown issues, though I wouldn't
expect the PHY to report the link as up, then.  Make sure that your
dts specifies the correct PHY address for the connected PHY.

What happens if you start up with the PHY connected, bring up the
interface, and *then* disconnect and reconnect the cable (after a
delay)?

Andy
