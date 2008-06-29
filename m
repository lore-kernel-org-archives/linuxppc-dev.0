Return-Path: <glikely@secretlab.ca>
Received: from qb-out-0506.google.com (qb-out-0506.google.com [72.14.204.230])
	by ozlabs.org (Postfix) with ESMTP id 9E01EDDE04
	for <linuxppc-dev@ozlabs.org>; Sun, 29 Jun 2008 14:31:14 +1000 (EST)
Received: by qb-out-0506.google.com with SMTP id d8so2660002qbc.37
	for <linuxppc-dev@ozlabs.org>; Sat, 28 Jun 2008 21:31:13 -0700 (PDT)
Date: Sat, 28 Jun 2008 22:31:11 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: Sean MacLennan <smaclennan@pikatech.com>
Subject: Re: [RFC] Non-numbered ibm iic driver
Message-ID: <20080629043111.GB13658@secretlab.ca>
References: <20080628232010.2bff2dcc@lappy.seanm.ca>
	<9e4733910806282025k6d9415c1g89ff47b739996159@mail.gmail.com>
	<20080628234339.382f31ac@lappy.seanm.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080628234339.382f31ac@lappy.seanm.ca>
Sender: Grant Likely <glikely@secretlab.ca>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Jun 28, 2008 at 11:43:39PM -0400, Sean MacLennan wrote:
> On Sat, 28 Jun 2008 23:25:05 -0400
> "Jon Smirl" <jonsmirl@gmail.com> wrote:
> 
> > On 6/28/08, Sean MacLennan <smaclennan@pikatech.com> wrote:
> > > This is a patch to the ibm iic driver that uses the non-numbered
> > >  i2c call and therefore does not need an index. Instead, it
> > > registers the ibm iic, then walks all the child nodes and adds
> > > them. This is required for new style drivers, old style drivers
> > > "just work".
> > 
> > Check out the code in drivers/of/of_i2c.c. Can you use it instead?
> 
> Sure can. The for loop can be replaced with:
> 
> 	of_register_i2c_devices(adap, np);
> 
> I have tested it and it works. I guess it makes sense to put of_i2c.c
> under drivers/of, but if it had been under drivers/i2c, I would have
> noticed it ;)
> 
> But is this the way we want to go? I personally like it. It gets rid of
> the index and gets rid of the i2c_register_board_info() from the
> platform code.

Oops, forgot to include the list on my first reply...

Yes, this is the way to go.  I've got a patch that does the same thing
for SPI busses which I need to post for 2nd review.

g.
