Return-Path: <jonsmirl@gmail.com>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.232])
	by ozlabs.org (Postfix) with ESMTP id ECA4ADE088
	for <linuxppc-dev@ozlabs.org>; Mon,  7 Jul 2008 23:39:45 +1000 (EST)
Received: by wx-out-0506.google.com with SMTP id i30so1054499wxd.15
	for <linuxppc-dev@ozlabs.org>; Mon, 07 Jul 2008 06:39:43 -0700 (PDT)
Message-ID: <9e4733910807070639k283b1267q34a4c9bbff827b22@mail.gmail.com>
Date: Mon, 7 Jul 2008 09:39:42 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Matt Sealey" <matt@genesi-usa.com>
Subject: Re: MPC52xx generic DMA using bestcomm
In-Reply-To: <4872104E.6050109@genesi-usa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <4871E487.2020008@matrix-vision.de>
	<4872104E.6050109@genesi-usa.com>
Cc: Andre Schwarz <andre.schwarz@matrix-vision.de>,
	linux-ppc list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 7/7/08, Matt Sealey <matt@genesi-usa.com> wrote:
>
>
>  Andre Schwarz wrote:
>
> > Grant,
> >
>
>  I know I'm not Grant, but..
>
>
> > do you know if someone's working on a more generic DMA solution using
> > BestComm engine on 5200B ?
> > Maybe somthing that accepts a sg-list with callback ops or completion ?
> >
>
>  It was suggested once or twice, not least by me.
>
>
> > Is it possible right now to accelerate simple memcpy ops ?
> >
>
>  From my discussions on the subject with Sylvain, it's possible, you just
>  need to use the GenBD and initiate it manually, however it's probably more
>  overhead than work if the data size is small, and BestComm would do better
>  to copy full 32-bit words at a time, and stay aligned, if you have an
> odd-sized
>  transfer from a non-32-bit aligned address, then you may have to do some
>  incredible amount of work which makes the actual transfer not worth doing
>  (by the time you set it up, the CPU could have copied it on it's own
>  already, I guess what you DO gain is a kernel preemption point.. the CPU
>  can do other things that are important)

If you want an Efika specific problem,  the audio hardware is capable
of simultaneously playing music on the S/PDIF and analog outputs. But
to do that the samples have to be alternated as they are fed into the
AC97 stream.  I think the codec can capture that way too but you
didn't put a transceiver on the S/PDIF line.

In my test driver you only get AC97 or S/PDIF. Grant and I are both
working on i2s drivers, when we get those sorted out it shouldn't be
too hard to add ac97 back in. That codec driver I sent you was about
95% complete.

>
>  I for one, though, whether it speeds stuff up or not, love to see this in
>  action and am very willing to test and benchmark it. I would love to see
>  more users, too, as the network stack is not the only system that can
>  benefit..
>
>  On a related note does anyone know of the status or what is going on with
>  Clifford Wolf's dmatransfer API?
>
>  --
>  Matt Sealey <matt@genesi-usa.com>
>  Genesi, Manager, Developer Relations
>
>  _______________________________________________
>  Linuxppc-dev mailing list
>  Linuxppc-dev@ozlabs.org
>  https://ozlabs.org/mailman/listinfo/linuxppc-dev
>


-- 
Jon Smirl
jonsmirl@gmail.com
