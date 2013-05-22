Return-Path: <sebastian.hesselbarth@gmail.com>
Received: from mail-ee0-f54.google.com (mail-ee0-f54.google.com [74.125.83.54])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1981B2C00A2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 May 2013 04:51:37 +1000 (EST)
Received: by mail-ee0-f54.google.com with SMTP id e50so1307415eek.27
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 May 2013 11:51:33 -0700 (PDT)
Message-ID: <519D13AE.4020807@gmail.com>
Date: Wed, 22 May 2013 20:51:26 +0200
From: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
MIME-Version: 1.0
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Subject: Re: [PATCH v4 06/12] ARM: dove: add gigabit ethernet and mvmdio device
 tree nodes
References: <1367854420-8006-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1369154510-4927-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1369154510-4927-7-git-send-email-sebastian.hesselbarth@gmail.com>
 <20130521174849.GL26249@lunn.ch> <519C9333.20609@gmail.com>
 <519C9822.9040909@windriver.com> <519C9A66.3050807@gmail.com>
 <20130522131010.GB31290@titan.lakedaemon.net>
 <20130522165908.GB12320@obsidianresearch.com> <519D0143.1000203@gmail.com>
 <20130522182448.GA17206@obsidianresearch.com>
In-Reply-To: <20130522182448.GA17206@obsidianresearch.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 "tiejun.chen" <tiejun.chen@windriver.com>,
 Lennert Buytenhek <buytenh@wantstofly.org>, linuxppc-dev@lists.ozlabs.org,
 David Miller <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/22/2013 08:24 PM, Jason Gunthorpe wrote:
> On Wed, May 22, 2013 at 07:32:51PM +0200, Sebastian Hesselbarth wrote:
>> Not neccessary anyway, after talking Jason C in a Kirkwood-only
>> workaround I prepared a patch that reads mac address registers early
>> and stores it in the local-mac-address property.
>
> That sounds great, but, FWIW, our bootloaders don't set the MAC
> address registers. Does the work around only trigger if the
> local-mac-address property is 0?

I already thought about bootloaders not setting the register, but I will
not start parsing 1001 places for a valid MAC only for those. Also
reading the MAC address registers is default behavior of mv643xx_eth if
no MAC address is passed through platform_data.

But you are right, there is plenty of sanity checks in the workaround to
ensure that local-mac-address is only overwritten by it when
- you are on DT
- there is no valid MAC address in that node (of_get_mac_address)
- there is a local-mac-address property with a length of 6 bytes

So this workaround only applies on DT booted kernels with no mac set in
DT.

Sebastian
