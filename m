Return-Path: <jwboyer@gmail.com>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by ozlabs.org (Postfix) with ESMTP id D2ABAB6EF0
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  2 Nov 2010 02:39:49 +1100 (EST)
Received: by wye20 with SMTP id 20so5737244wye.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 01 Nov 2010 08:39:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20101102023650.bc553e74.sfr@canb.auug.org.au>
References: <6631e123845856ac20423c25e07844c8@mail.gmail.com>
	<AANLkTikWWGpAM8+_z9fnngYuYSpT3NWgM7xeGkOzZ3jg@mail.gmail.com>
	<AANLkTikQuUcAMZKqZ3Rz5HVzOs+63-Y4VYUo5-3EM30H@mail.gmail.com>
	<20101102023650.bc553e74.sfr@canb.auug.org.au>
Date: Mon, 1 Nov 2010 11:39:47 -0400
Message-ID: <AANLkTin3nsb6FfNtXfqjZCuV66mwKVOsKgmZpTABFDUJ@mail.gmail.com>
Subject: Re: All Applied micro boards are failing with current mainline kernel
From: Josh Boyer <jwboyer@gmail.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Eric Dumazet <eric.dumazet@gmail.com>, Rupjyoti Sarmah <rsarmah@apm.com>,
	linux-kernel@vger.kernel.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	"David S. Miller" <davem@davemloft.net>, Tom Herbert <therbert@google.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Nov 1, 2010 at 11:36 AM, Stephen Rothwell <sfr@canb.auug.org.au> wr=
ote:
> Hi Josh,
>
> On Mon, 1 Nov 2010 11:05:53 -0400 Josh Boyer <jwboyer@gmail.com> wrote:
>>
>> A few hints would be appreciated.
>
> Remove the call to netif_stop_queue() from emac_probe(). =A0Apparently,
> calling this before register_netdev() is now wrong (maybe always was).

Yeah, I just discovered that myself.  I'm wondering

1) why we do that in that function?
2) If it needs to be removed entirely, or moved to after the
register_netdev call
3) If the call to netif_carrier_off also needs similar attention.

I can whip up a patch to remove those calls or move them after the
register, but I don't want to do that without knowing which one is
"right".

josh
