Return-Path: <Stefan.Nickl@kontron.com>
Received: from kom-mail1.kontron-modular.com (unknown [62.159.155.196])
	by ozlabs.org (Postfix) with ESMTP id 3FAAC67A73
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 24 Mar 2005 18:44:14 +1100 (EST)
From: Stefan Nickl <Stefan.Nickl@kontron.com>
To: Eugene Surovegin <ebs@ebshome.net>
In-Reply-To: <20050323171046.GA28922@gate.ebshome.net>
References: <BAY1-DAV1357D81F947F1A31523FE48B4F0@phx.gbl>
	<1111571205.13392.3.camel@lucy.pep-kaufbeuren.de>
	<20050323171046.GA28922@gate.ebshome.net>
Content-Type: text/plain
Date: Thu, 24 Mar 2005 08:44:08 +0100
Message-Id: <1111650248.12512.9.camel@lucy.pep-kaufbeuren.de>
Mime-Version: 1.0
Cc: Vijay Padiyar <vijay_padiyar@hotmail.com>,
	LinuxPPC Support <linuxppc-embedded@ozlabs.org>
Subject: Re: question about writing to memory directly from user space in
	Linux
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, 2005-03-23 at 09:10 -0800, Eugene Surovegin wrote:
> On Wed, Mar 23, 2005 at 10:46:45AM +0100, Stefan Nickl wrote:
> > On Wed, 2005-03-23 at 14:25 +0530, Vijay Padiyar wrote:
> > > Can you suggest some kind of a "synchronization" function which I can call
> > > from *user space* which will ensure that all values written to mmaped memory
> > > locations from user space are actually flushed to their physical locations?
> > > I think this might be a potential problem with my code.
> > 
> > Have a look at linux/include/asm-ppc/{io.h,system.h} and
> > http://www.xml.com/ldd/chapter/book/ch08.html
> > 
> > The eieio instruction doesn't need supervisor rights.
> 
> eieio is a nop on 603e core.

Interesting, I was not aware of this.

eieio is handled differently between MPC8245 and MPC8260.

Anyways, it's a non-issue as IO memory should have the right WIMG bits
set to take care of this, and modelling it with a in-kernel i2c bus as
suggested on the list is soo much nicer.

-- 
Stefan Nickl
Kontron Modular Computers
