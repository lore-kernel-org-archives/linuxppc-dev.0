From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ethan Blanton <eblanton@cs.ohiou.edu>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: Clock drift on an iBook2
Date: Tue, 17 Jul 2001 18:52:31 +0200
Message-Id: <20010717165231.25195@smtp.adsl.oleane.com>
In-Reply-To: <20010717165032.5490@smtp.adsl.oleane.com>
References: <20010717165032.5490@smtp.adsl.oleane.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>I have a new iBook2 and I'm having *severe* clock drift problems -- on
>>the order of several seconds gained per minute.  I'd like to get this
>>taken care of, and it seems to be a linux problem as OSX appears to
>>have a stable clock.
>>
>>I'm running BenH's 2.4.7-pre6 right now, but I also saw it on 2.4.6.
>>
>>Is this a known problem?  If not, what can I do to help get this fixed?
>>Ethan
>
>Are you using MOL or do you experience this with nothing special running ?
>
>Do you have the same issue if you disable powersave_nap (/proc/sys/
>kernel/powersave_nap) ?
>
>The TB is calibrated using the VIA, if we don't have a correct VIA frequency
>or if the calibration routine is slightly off, that may also explain the
>problem.

Something else you can try: in arch/ppc/kernel/pmac_time.c, comment
out the call to via_calibrate_decr() (and the return too) so that
we use the device-tree "timebase-frequency" instead, and tell us if
it makes any difference.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
