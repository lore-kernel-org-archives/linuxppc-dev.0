Message-ID: <3EC26EAD.8080200@embeddededge.com>
Date: Wed, 14 May 2003 12:28:29 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Gabriel Paubert <paubert@iram.es>
Cc: Paul Mackerras <paulus@samba.org>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: set_rtc_time() cleanup / normalization
References: <20030512211733.B489EC6092@atlas.denx.de> <16065.31312.163813.582334@argo.ozlabs.ibm.com> <20030514154310.GC9430@iram.es>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Gabriel Paubert wrote:

> Ask on the ntp lists first, I bet you'll upset a lot of people
> if you suggest it.

I'll bet no one is using it on a system that has an unpredictable
latency, interrupt generating, i2c RTC, either. :-)

The solution is to do like other architectures and allow (as Tom
suggested) a selectable rtc update function.  Although I may use
a particular RTC driver, I may not want the update function that
comes along with it.  All we need is an indirect function pointer
to the get/set functions that is initialized by the board set
up functions.  By default they should be null functions, if you
want something else, put a pointer there.

The fact is the current rtc update functions are not suitable for
embedded boards that have to meet latency guarantees.  They simply
add overhead, often in a bad way, even if implemented correctly.
Installing any kind of real-time enhancement (like RTLinux or RTAI)
will cause a failure of the rtc update model because the update thread of
control can be easily preempted.

The solution is easy, you can find examples in other architectures,
and we don't have to argue about it.

Thanks.


	-- Dan


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
