Return-Path: <segher@kernel.crashing.org>
In-Reply-To: <471E12C7.8020509@freescale.com>
References: <9e4733910710221859q6ea54810nba58907d5ddd966d@mail.gmail.com>
	<471E12C7.8020509@freescale.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <8416ea754e013a67441aec778c81ad73@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Audio codec device tree entries
Date: Tue, 23 Oct 2007 18:56:04 +0200
To: Timur Tabi <timur@freescale.com>
Cc: PowerPC dev list <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> First example is ac97 audio:
>>
>> ac97@2000 {           // PSC1

> I think the codec node should be a child of this node, not a separate 
> node.
> Then there should be another codec node as a child of the i2c node.

AC'97 codecs don't typically have an I2C connection (if ever).

You shouldn't have two device nodes for the same device if ever you
can help it; instead, have the device's sole device node contain a
property that points to the device node of its secondary bus.  That
property could be called "i2s-handle" for a standard codec (which
probably is a direct child of an IIC bus, itself).


Segher
