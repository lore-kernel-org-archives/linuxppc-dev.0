Date: Fri, 14 Jan 2000 15:07:16 -0600
From: Grant Erickson <grant@lcse.umn.edu>
To: Charles Lepple <clepple@mitre.org>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: *_find_end_of_memory Mach Dep?
In-Reply-To: <387F8EB3.B8098131@mitre.org>
Message-ID: <Pine.SGI.4.10.10001141504430.254646-100000@brule.borg.umn.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 14 Jan 2000, Charles Lepple wrote:
> Grant Erickson wrote:
> > 
> > Instead of having a mess of ifdef's and such in MMU_init for {apus, pmac,
> > m8xx, oak, chrp, etc}_find_end_of_memory, is there any compelling reason
> > not to make a ppc_md machine dependency entry for these?
> 
> When I converted some code to the ppc_md interface, I seem to remember a
> few cases where I couldn't do it that way because the ppc_md structure
> was not completely filled out. It can get to be a catch-22 -- there has
> to be one messy function.

Fair enough. However, since identify_machine is called before MMU_init and
<platform>_init is called in identify_machine, then it's reasonable that
the ppc_md structure is filled out by the time we hit MMU_init.

So, it seems reasonable that "identify_machine" remains the messy
function and MMU_init could be cleaned up somewhat.

Grant


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
