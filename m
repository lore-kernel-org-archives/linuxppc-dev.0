From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Matthias Grimm <joker@cymes.de>,
	"Joseph P. Garcia" <jpgarcia@execpc.com>
Cc: LinuxPPC-Dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Design weakness in /proc/pmu ?!
Date: Fri, 19 Apr 2002 19:06:07 +0200
Message-Id: <20020419170607.14385@smtp.adsl.oleane.com>
In-Reply-To: <3CC046A2.5030708@cymes.de>
References: <3CC046A2.5030708@cymes.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>Exactly that is our problem. The dumps are from a PowerBook Wallstreet
>and sent to me because I did the calculation in pbbuttonsd as I have
>written and ran into this problem.
>
>On newer machines do you get a single overall system value for the time
>remaining or one for each battery? Nevertheless it would be easy to
>calculate _one_ valid value and store it in /proc/pmu/info.

Not that easy if we want it really valid. Note that we could still
use the other (older) PMU battery functions, maybe one of them
returns some kind of cumulated time.

>And if the algorithm to calculate the remaining time wasn't known the
>more it would be nessecary to have a reliable overall time because
>applications can't find it by themselves anymore in the future.
>Work-arounds weren't possible due to lack of information.
>
>
>> So its not really a bug, just an implemenetation decision that mirrors the
>> hardware.  But I'm all for Matthias' suggestion.  The alternative is to do
>> what I had the gkrellm pmu plugin do. (without letting it know how to
>> redundantly find the time on its own just using ratios, but that assumes a
>> linear function)
>
>Yes and if the number of battery types increases every application will
>run into problems calulating missing values on there own. Only the
>kernel could do this and as Ben already correctly said: He would keep
>such a complicated piece of code in one single place.
>
>The move would make the information in /proc/pmu more logical because
>all values stored in /proc/pmu/batery_* except the remaining time were
>all features of that battery and could stand for itself. The remaining
>time makes only sense if you know the current power consumption of the
>_whole_ computer too.
>
>It would also be fantasic if the capacitance in mAh (mili Ampere
>hours)or maybe mWh (mili Watt hours) could be added to the battery
>files, but I'm not shure if you get this information from the PMU or
>could calculate it out of known parameters. And at the moment this value
>is only nice-to-have.
>
>   Best Regards
>     Matthias
>
>
>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
