Return-Path: <neko@genesi-usa.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.169])
	by ozlabs.org (Postfix) with ESMTP id 0A25ADE02C
	for <linuxppc-dev@ozlabs.org>; Mon,  7 Jul 2008 22:47:10 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id k3so930448ugf.0
	for <linuxppc-dev@ozlabs.org>; Mon, 07 Jul 2008 05:47:08 -0700 (PDT)
Message-ID: <4872104E.6050109@genesi-usa.com>
Date: Mon, 07 Jul 2008 13:47:10 +0100
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: Andre Schwarz <andre.schwarz@matrix-vision.de>
Subject: Re: MPC52xx generic DMA using bestcomm
References: <4871E487.2020008@matrix-vision.de>
In-Reply-To: <4871E487.2020008@matrix-vision.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: Matt Sealey <neko@genesi-usa.com>
Cc: linux-ppc list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



Andre Schwarz wrote:
> Grant,

I know I'm not Grant, but..

> do you know if someone's working on a more generic DMA solution using
> BestComm engine on 5200B ?
> Maybe somthing that accepts a sg-list with callback ops or completion ?

It was suggested once or twice, not least by me.

> Is it possible right now to accelerate simple memcpy ops ?

 From my discussions on the subject with Sylvain, it's possible, you just
need to use the GenBD and initiate it manually, however it's probably more
overhead than work if the data size is small, and BestComm would do better
to copy full 32-bit words at a time, and stay aligned, if you have an odd-sized
transfer from a non-32-bit aligned address, then you may have to do some
incredible amount of work which makes the actual transfer not worth doing
(by the time you set it up, the CPU could have copied it on it's own
already, I guess what you DO gain is a kernel preemption point.. the CPU
can do other things that are important)

I for one, though, whether it speeds stuff up or not, love to see this in
action and am very willing to test and benchmark it. I would love to see
more users, too, as the network stack is not the only system that can
benefit..

On a related note does anyone know of the status or what is going on with
Clifford Wolf's dmatransfer API?

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations
