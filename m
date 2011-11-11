Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 2CC2DB6F97
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Nov 2011 15:51:19 +1100 (EST)
Message-ID: <1320987054.21206.55.camel@pasglop>
Subject: Re: [RFC PATCH 02/17] powerpc: Split up PHYS_64BIT config option to
 fix "select" issues
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Timur Tabi <timur@freescale.com>
Date: Fri, 11 Nov 2011 15:50:54 +1100
In-Reply-To: <4EBC00D2.2030208@freescale.com>
References: <4E42AB6F.1050900@freescale.com>
 <1320883635-17194-3-git-send-email-Kyle.D.Moffett@boeing.com>
 <4EBBD9DF.6080100@freescale.com>
 <501ACA94-491F-43A7-9DCF-485BEE824DD5@boeing.com>
 <4EBC00D2.2030208@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Baruch Siach <baruch@tkos.co.il>, Sonny Rao <sonnyrao@linux.vnet.ibm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Paul Gortmaker <paul.gortmaker@windriver.com>,
 Paul Mackerras <paulus@samba.org>, "Moffett,
 Kyle D" <Kyle.D.Moffett@boeing.com>, Scott Wood <scottwood@freescale.com>,
 Anatolij Gustschin <agust@denx.de>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Paul Bolle <pebolle@tiscali.nl>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2011-11-10 at 10:50 -0600, Timur Tabi wrote:

> I'm not sure that Kconfig rule is enforceable.  We use 'select' all the time to make sure that our boards enable the options that need to be enabled.  I'd rather see this:
> 
> config X
> 	select A
> 
> config Y
> 	select A
> 
> config Z
> 	select A
> 
> than this:
> 
> config A
> 	default y if X | Y | Z
> 
> The former is more maintainable and does not allow the option of disabling "A" if someone wants "X".

This is fine as long as config A is not a user selectable option.

We do the wrong thing in a few places (i2c comes to mind) and we should
most certainly consider fixing it. Some of the solution is to move some
select's to defconfigs, some is to do things the way Kyle proposed.

For PHYS_64BIT, I'm not 100% certain at this point what the best
approach it. It should clearly be fixed and hidden for real 64-bit. As
for the rest, should it be user selectable ? I tend to think it should
be fixed & selected by the board config and keep it that way, avoiding
the user question entirely... but you may have good reasons to want to
keep it around.

Cheers,
Ben.
