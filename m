Return-Path: <ddaney.cavm@gmail.com>
Message-ID: <4FB6CBF1.40300@gmail.com>
Date: Fri, 18 May 2012 15:23:45 -0700
From: David Daney <ddaney.cavm@gmail.com>
MIME-Version: 1.0
To: Timur Tabi <b04825@freescale.com>
Subject: Re: [PATCH v6 0/3] netdev/of/phy: MDIO bus multiplexer support.
References: <1336007799-31016-1-git-send-email-ddaney.cavm@gmail.com>
 <CAOZdJXWVCu+aNxcQRkcSSDsWWxnn8B9X5Y6=8oVgFwJ9SZTTGQ@mail.gmail.com>
 <4FB6C728.3090507@gmail.com> <4FB6C886.3050105@freescale.com>
In-Reply-To: <4FB6C886.3050105@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "devicetree-discuss@lists.ozlabs.org"
 <devicetree-discuss@lists.ozlabs.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/18/2012 03:09 PM, Timur Tabi wrote:
> David Daney wrote:
>>>> I'm not sure what the "parent" MDIO bus node is supposed to represent.
>>>>    Is that that device that actually controls the muxing hardware
>
>> No.  It is the device that implements the master 802.3 clause {22,45}
>> MDIO Station Management (STA) protocol.
>
> Ah, I think I get it.  It is *the* MDIO node that would normally exist if
> muxing we're necessary on the board.  From the looks of it, that node
> would look exactly the same if you didn't need muxing?
>

Yes.  You may note in the DTS file I attached in the parent (sorry for 
the fubar mime types), that there are two, almost identical, MDIO 
masters.  smi0 has two directly attached PHYs.  smi1 goes to the mux, 
and each child of the mux has four attached PHYs.

This is a fairly complex configuration as the GPIOs controlling the MDIO 
mux are on I2C GPIO expanders which are themselves behind an I2C mux...

The nice thing about this is that the Linux I2C and MDIO infrastructure 
is all configured dynamically from the device tree and everything works 
well together with no locking issues.  The addition of the deferred 
driver probe mechanism was the last part of the puzzle (I think... 
actually I don't know if all my I2C things are merged yet...).

David Daney
