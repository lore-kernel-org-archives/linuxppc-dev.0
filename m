Return-Path: <dgibson@ozlabs.org>
Date: Fri, 13 Feb 2009 00:30:37 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jean-Michel Hautbois <jhautbois@gmail.com>
Subject: Re: [MPC8272ADS]Problem adding flash partitions inside the device tree
Message-ID: <20090212133037.GA3651@yookeroo.seuss>
References: <8cad0aa0902120123p27cfe32fg6bf08d458178c937@mail.gmail.com>
	<49940265.1020700@vastech.co.za>
	<8cad0aa0902120310g44a3bf3cla4ffa94ea9bf5dc6@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <8cad0aa0902120310g44a3bf3cla4ffa94ea9bf5dc6@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Feb 12, 2009 at 12:10:58PM +0100, Jean-Michel Hautbois wrote:
> 2009/2/12 Pieter <phenning@vastech.co.za>
> 
> > Jean-Michel Hautbois wrote:
> > > Warning (reg_format): "reg" property in
> > > /localbus@f0010100/flash@0,0/partition@ff800000 has invalid length (8
> > > JM
> > You are missing some definitions, The #address-cells and #size-cells = <1>;
> > tis is a snippet of teh dts i defined for my board.
> >
> >        flash@0,0 {
> >            #address-cells = <1>;
> >            #size-cells = <1>;
> >            compatible = "cfi-flash";
> >            reg = <0x0 0x0 0x08000000>;
> >             bank-width = <4>;
> >            device-width = <1>;
> >
> >             /* set flash partition to correspond tu mtd parts in
> > u-boot*/
> >            /*     0xf8000000 */
> >            partition@0x0 {
> >                label = "factory-image";
> >                reg = <0x00000000 0x01000000>;
> >            };
> >            /*     0xf9000000 */
> >            partition@0x01000000 {
> >                label = "app-image-1";
> >                reg = <0x01000000 0x01000000>;
> >            };
> > cheers pieter
> >
> 
> Hi do have these definitions, at a higher level:

The address-cells and size-cells definitions are not inherited.  They
cover only the immediate children of the node where they appear.
Otherwise the default values apply (address-cells == 2, size-cells ==
1), which are not right for your case.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
