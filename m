Return-Path: <jonsmirl@gmail.com>
Message-ID: <9e4733910711101544v178e29cer4e53577c011e89f7@mail.gmail.com>
Date: Sat, 10 Nov 2007 18:44:59 -0500
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Kumar Gala" <galak@kernel.crashing.org>
Subject: Re: IRQs in i2c-mpc.c
In-Reply-To: <A4797E92-9FCF-484A-B6AA-9385913AD465@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <9e4733910711101144r3f8745dbs572aefa8658e1312@mail.gmail.com>
	<3DBBAC12-579B-4C1F-9C9E-D085FB22B687@kernel.crashing.org>
	<9e4733910711101516n64870e40rbd1fcbe3d123fcc3@mail.gmail.com>
	<A4797E92-9FCF-484A-B6AA-9385913AD465@kernel.crashing.org>
Cc: PowerPC dev list <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 11/10/07, Kumar Gala <galak@kernel.crashing.org> wrote:
>
> On Nov 10, 2007, at 5:16 PM, Jon Smirl wrote:
>
> > On 11/10/07, Kumar Gala <galak@kernel.crashing.org> wrote:
> >> Looking at the current driver it looks like we could get ride of if
> >> check since the previous code checked the return of
> >> platform_get_irq().
> >
> > The code was a snippet from the larger patch that is converting i2c
> > from being a platform driver to a of_platform driver.
> >
> > The question is, what to do about a missing IRQ tag in the device tree
> > or a IRQ of zero. What is an error and what should be ignored, etc.
>
> I think the lack of an IRQ in the device tree should be an error.  If
> the IRQ value is zero, than its zero.

irq_of_parse_and_map() returns NO_IRQ when the irq parameter is missing.

This API appears to be broken. In asm-powerpc/irq.h NO_IRQ is defined
as (0). There is no way to tell an error in the attribute from a valid
attribute selecting interrupt zero.

NO_IRQ used to be (-1).

/* This number is used when no interrupt has been assigned */
#ifdef CONFIG_PPC_MERGE
#define NO_IRQ                  (0)
#else
#define NO_IRQ                  (-1)


-- 
Jon Smirl
jonsmirl@gmail.com
