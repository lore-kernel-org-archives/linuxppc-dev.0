Return-Path: <f.fainelli@gmail.com>
Sender: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <5107EC56.2000703@openwrt.org>
Date: Tue, 29 Jan 2013 16:35:50 +0100
From: Florian Fainelli <florian@openwrt.org>
MIME-Version: 1.0
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH 1/5] net: mvmdio: unmap base register address at driver
 removal
References: <1359473048-26551-1-git-send-email-florian@openwrt.org>
 <1359473048-26551-2-git-send-email-florian@openwrt.org>
 <20130129163242.1df2caf5@skate>
In-Reply-To: <20130129163242.1df2caf5@skate>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: Andrew Lunn <andrew@lunn.ch>, Russell King <linux@arm.linux.org.uk>,
 Jason Cooper <jason@lakedaemon.net>, linux-doc@vger.kernel.org,
 devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Rob Herring <rob.herring@calxeda.com>, netdev@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, linux-arm-kernel@lists.infradead.org,
 Rob Landley <rob@landley.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linuxppc-dev@lists.ozlabs.org, davem@davemloft.net,
 Lennert Buytenhek <buytenh@wantstofly.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/29/2013 04:32 PM, Thomas Petazzoni wrote:
> Dear Florian Fainelli,
>
> On Tue, 29 Jan 2013 16:24:04 +0100, Florian Fainelli wrote:
>> Fix the driver remove callback to unmap the base register address and
>> not leak this mapping after the driver has been removed.
>>
>> Signed-off-by: Florian Fainelli <florian@openwrt.org>
> What about using devm_request_and_ioremap() instead, in order to get
> automatic unmap on error and in the ->remove() path?

Right now, you are using of_iomap() which eases the task of fetching the 
resource and getting an ioremap cookie, which I why I kept that.

>
> But maybe it won't work because this memory range is claimed both by
> the MDIO driver and the Ethernet driver itself. In that case, you could
> use devm_ioremap().
Then we would loose the facility of of_iomap(), but fair enough, it can 
be inserted as a patch in this serie.

Thanks
--
Florian
