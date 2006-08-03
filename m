Return-Path: <linuxppcleo@gmail.com>
Message-ID: <a0bc9bf80608030947n3a73590epf299db09b7227b47@mail.gmail.com>
Date: Fri, 4 Aug 2006 00:47:00 +0800
From: "Li Yang" <LeoLi@freescale.com>
Sender: linuxppcleo@gmail.com
To: "Matthew McClintock" <msm@freescale.com>
Subject: Re: [RFC] New target 'cuImage' - compatibility uImage
In-Reply-To: <1154622246.5094.18.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <20060802223302.9667135360F@atlas.denx.de>
	<1154618945.5094.6.camel@localhost>
	<a0bc9bf80608030856p45870487of2646c4f9393869b@mail.gmail.com>
	<1154620934.5094.12.camel@localhost>
	<a0bc9bf80608030917y7fde2b75n6719dc675cad8cfe@mail.gmail.com>
	<1154622246.5094.18.camel@localhost>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 8/4/06, Matthew McClintock <msm@freescale.com> wrote:
> On Fri, 2006-08-04 at 00:17 +0800, Li Yang wrote:
> >
> > Though it will need more space, the increase won't be too much as
> > wrapper and FDT should be very small.  The benefit is that kernel can
> > be extract directly to it's destination(address 0), rather than
> > extract to another place and then move it there.  A classical
> > time/space tradeoff.
> >
>
> I'm not sure that is correct. Let me walk through the steps to verify.
>
> 1) Load cuImage at a load address
> 2) Extract zImage at an address and begin execution
> 3) Copy kernel to load address and fixup DTB, etc.
> 4) Start kernel execution
>
> versus...
>
> 1) Load cuImage at a load address
> 2) Copy zImage to an address and begin execution

Don't know if it's possible to by-pass this by setting in u-boot
header.  If not, please ignore my suggestion.

- Leo
> 3) Extract kernel to load address and fixup DTB, etc.
> 4) Start kernel execution
>
> There will always be that extra copy in there vs. just running the
> zImage itself. This is to maintain compatibility with older u-boots,
> which is the main point of this target.
>
> Am I missing something here?
>
> -Matthew
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>
