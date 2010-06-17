Return-Path: <gary@mlbassoc.com>
Received: from mail.chez-thomas.org (hermes.mlbassoc.com [76.76.67.137])
	by ozlabs.org (Postfix) with ESMTP id 9FF06B6F11
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jun 2010 04:50:19 +1000 (EST)
Message-ID: <4C1A6E6A.8010207@mlbassoc.com>
Date: Thu, 17 Jun 2010 12:50:18 -0600
From: Gary Thomas <gary@mlbassoc.com>
MIME-Version: 1.0
To: Linux PPC Development <linuxppc-dev@ozlabs.org>
Subject: Re: Fixed-link PHY question
References: <4C1A61D9.4020306@mlbassoc.com>
In-Reply-To: <4C1A61D9.4020306@mlbassoc.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/17/2010 11:56 AM, Gary Thomas wrote:
> I'm working with 2.6.33.3 on a MPC8358.  I'm trying to get it
> to talk to a Marvell (DSA) switch which uses special drivers
> and addressing to act like a PHY. I have this working fine
> on some older (2.6.28) systems by using a fixed-link PHY
> descriptor in my device tree (using the TSEC on 8347).
>
> The GETH driver calls 'of_phy_connect_fixed_link' which
> always gives me this error:
> PHY 0:01 not found
> net eth1: Could not attach to PHY
>
> How can I get the GETH driver to just accept the pseudo
> PHY connection specified by
> fixed-link = <1 1 1000 0 0>;

Figured it out - my ethernet node in the device tree has
to be called 'ethernet' for the fixed PHY emulation to see
the fixed-link properties.

Seems rather limited, but I don't have time to change it.

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------
