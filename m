Date: Tue, 26 Sep 2000 12:38:59 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: Paul Mackerras <paulus@linuxcare.com.au>
cc: mlan@cpu.lu, linuxppc-dev@lists.linuxppc.org
Subject: Re: zeroing pages in the idle task?
In-Reply-To: <14784.22458.21233.588776@argo.linuxcare.com.au>
Message-ID: <Pine.HPX.4.10.10009261219380.24143-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 14 Sep 2000, Paul Mackerras wrote:

>
> Michel Lanners writes:
>
> > > - if not, would it be a good idea to enable it by default?
> >
> > What do you think, Paul, Cort?
>
> As I recall, it was necessary to disable the cache in the idle task so
> that the idle task's clearing of pages didn't trash the cache for
> other tasks.

why ? When you are sleeping, the next task to run may or may not be the
same.

If it is the same, you loose, but any task sleeping should not expect
the caches to be hot when it restarts....

It it is not the same and you take care of cleaning the cache (with dcbst,
not dcbf to opimize the case where you need a new allocation just after
the switch to an active task), then you will end up with less dirty cache
line pushes when the new task is started, effectively speeding up the task
switch.

On SMP bus utlilization may be an issue, but dcbz+dcbst is not that
expensive after all (2 address cycles and one data burst).

	Regards,
	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
