Date: Thu, 18 Apr 2002 15:56:10 -0500
From: "Joseph P. Garcia" <jpgarcia@execpc.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: joker@cymes.de, linuxppc-dev@lists.linuxppc.org
Subject: Re: Design weakness in /proc/pmu ?!
Message-Id: <20020418155610.28459dcc.jpgarcia@execpc.com>
In-Reply-To: <20020418183148.25976@smtp.wanadoo.fr>
References: <3CBF14C1.6080802@cymes.de>
	<20020418183148.25976@smtp.wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Greetings Ben, Matthias, and others.

On Thu, 18 Apr 2002 20:31:47 +0200
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> It's difficult to find a suitable answer. The time remaining is
> obtained directly from the PMU  on newer machines, we don't really
> have the proper algorithm to calculate it on these, what
> machine did you get those dumps from ? We may simply have a bug
> on older machine calculation causing that 0, in which case it
> has to be fixed.

Each battery in the current code is handled seperately.  Each battery has
its own value for current.  A battery not in use has a value of 0, which
the time calculations handle by saying 0 time left, as if you're plugged in
and not charging, this is what would be expected.

So its not really a bug, just an implemenetation decision that mirrors the
hardware.  But I'm all for Matthias' suggestion.  The alternative is to do
what I had the gkrellm pmu plugin do. (without letting it know how to
redundantly find the time on its own just using ratios, but that assumes a
linear function)

--
Joseph P. Garcia    http://www.lycestra.com/    http://lidar.ssec.wisc.edu/
CS Undergraduate                      Student Employee - Systems Programmer
University of Wisconsin - Madison                            UW Lidar Group

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
