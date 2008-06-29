Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id DD657DDDFC
	for <linuxppc-dev@ozlabs.org>; Sun, 29 Jun 2008 13:43:41 +1000 (EST)
Date: Sat, 28 Jun 2008 23:43:39 -0400
From: Sean MacLennan <smaclennan@pikatech.com>
To: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: [RFC] Non-numbered ibm iic driver
Message-ID: <20080628234339.382f31ac@lappy.seanm.ca>
In-Reply-To: <9e4733910806282025k6d9415c1g89ff47b739996159@mail.gmail.com>
References: <20080628232010.2bff2dcc@lappy.seanm.ca>
	<9e4733910806282025k6d9415c1g89ff47b739996159@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 28 Jun 2008 23:25:05 -0400
"Jon Smirl" <jonsmirl@gmail.com> wrote:

> On 6/28/08, Sean MacLennan <smaclennan@pikatech.com> wrote:
> > This is a patch to the ibm iic driver that uses the non-numbered
> >  i2c call and therefore does not need an index. Instead, it
> > registers the ibm iic, then walks all the child nodes and adds
> > them. This is required for new style drivers, old style drivers
> > "just work".
> 
> Check out the code in drivers/of/of_i2c.c. Can you use it instead?

Sure can. The for loop can be replaced with:

	of_register_i2c_devices(adap, np);

I have tested it and it works. I guess it makes sense to put of_i2c.c
under drivers/of, but if it had been under drivers/i2c, I would have
noticed it ;)

But is this the way we want to go? I personally like it. It gets rid of
the index and gets rid of the i2c_register_board_info() from the
platform code.

Cheers,
   Sean
