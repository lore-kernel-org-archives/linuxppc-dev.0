Message-ID: <3CC046A2.5030708@cymes.de>
Date: Fri, 19 Apr 2002 18:32:34 +0200
From: Matthias Grimm <joker@cymes.de>
MIME-Version: 1.0
To: "Joseph P. Garcia" <jpgarcia@execpc.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: LinuxPPC-Dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Design weakness in /proc/pmu ?!
References: <3CBF14C1.6080802@cymes.de>	<20020418183148.25976@smtp.wanadoo.fr> <20020418155610.28459dcc.jpgarcia@execpc.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Joseph P. Garcia wrote:

> Greetings Ben, Matthias, and others.
>
> On Thu, 18 Apr 2002 20:31:47 +0200
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
>
>>It's difficult to find a suitable answer. The time remaining is
>>obtained directly from the PMU  on newer machines, we don't really
>>have the proper algorithm to calculate it on these, what
>>machine did you get those dumps from ? We may simply have a bug
>>on older machine calculation causing that 0, in which case it
>>has to be fixed.
>>
>
> Each battery in the current code is handled seperately.  Each battery has
> its own value for current.  A battery not in use has a value of 0, which
> the time calculations handle by saying 0 time left, as if you're plugged in
> and not charging, this is what would be expected.


Exactly that is our problem. The dumps are from a PowerBook Wallstreet
and sent to me because I did the calculation in pbbuttonsd as I have
written and ran into this problem.

On newer machines do you get a single overall system value for the time
remaining or one for each battery? Nevertheless it would be easy to
calculate _one_ valid value and store it in /proc/pmu/info.

And if the algorithm to calculate the remaining time wasn't known the
more it would be nessecary to have a reliable overall time because
applications can't find it by themselves anymore in the future.
Work-arounds weren't possible due to lack of information.


> So its not really a bug, just an implemenetation decision that mirrors the
> hardware.  But I'm all for Matthias' suggestion.  The alternative is to do
> what I had the gkrellm pmu plugin do. (without letting it know how to
> redundantly find the time on its own just using ratios, but that assumes a
> linear function)

Yes and if the number of battery types increases every application will
run into problems calulating missing values on there own. Only the
kernel could do this and as Ben already correctly said: He would keep
such a complicated piece of code in one single place.

The move would make the information in /proc/pmu more logical because
all values stored in /proc/pmu/batery_* except the remaining time were
all features of that battery and could stand for itself. The remaining
time makes only sense if you know the current power consumption of the
_whole_ computer too.

It would also be fantasic if the capacitance in mAh (mili Ampere
hours)or maybe mWh (mili Watt hours) could be added to the battery
files, but I'm not shure if you get this information from the PMU or
could calculate it out of known parameters. And at the moment this value
is only nice-to-have.

   Best Regards
     Matthias


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
