From: John Steele Scott <toojays@toojays.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] cpufreq support for 7447A on 2004 iBooks
Date: Thu, 10 Jun 2004 21:04:35 +0930
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>,
	Christiaan Welvaart <cjw@daneel.dyndns.org>, cpufreq@www.linux.org.uk
References: <200406051846.50718.toojays@toojays.net> <1086452473.12664.36.camel@gaston>
In-Reply-To: <1086452473.12664.36.camel@gaston>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <200406102105.27654.toojays@toojays.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



On Sun, 6 Jun 2004 01:51 am, Benjamin Herrenschmidt wrote:
> I suggest you also look at the latest Darwin code Apple released, more
> sepecifically AppleMacRISC2PE. There is some new bits including something
> about tweaking a bus delay when changing the frequency on these models.

I had time to have a look at this today (actually, I didn't have time, but I
looked at it anyway :). There is a register in the UniNorth which controls
whether the address acknowledge will be delayed or not. This delay is not
required when running at high speed.

I have made a new patch for this, available from:
http://www.toojays.net/~toojays/misc/7447a_cpufreq_20040610.patch

This is a fair bit larger than the previous patch, as I have added a function
to the intrepid feature table to control the AACK delay. There is a slight
performance improvement for processes which are bound by memory latency (e.g.
repeatedly cat'ing a 180MB file to /dev/null takes 0.270s with this patch
versus 0.277s with the last one).

This patch also accepts the PowerBook5,4 models. One thing that needs checking
as that the revision of UniNorth on this model is high enough for
intrepid_aack_delay_enable to do its thing. I just assumed that they have the
same UniNorth, but I will ask in the forum thread which Colin pointed to
earlier tonight.

cheers,

John

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
