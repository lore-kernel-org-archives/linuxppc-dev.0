Message-ID: <19990126184501.B8495@belltower.dartmouth.edu>
Date: Tue, 26 Jan 1999 18:45:01 -0500
From: Jeff Dubrule <igor@pobox.com>
To: Ira Joseph Woodhead <ira@wrath.iatlas.com>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: pre-R5 deficiencies
References: <199901262207.RAA06012@wrath.iatlas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <199901262207.RAA06012@wrath.iatlas.com>; from Ira Joseph Woodhead on Tue, Jan 26, 1999 at 05:07:22PM -0500
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Jan 26, 1999 at 05:07:22PM -0500, Ira Joseph Woodhead wrote:
> 
> 
> Hi all,
> 
> Perhaps I'm rehashing something but I couldn't find it searching the
> archives, so:
> 
> What is the reasoning behind including a findutils in pre-R5 that has no
> updatedb binary?? It even has scripts that use updatedb (cron jobs) but
> no updatedb binary. Furthermore, 'rpm -qlp *.rpm' reveals that it is not
> included in any package.
> 
> After quite a lot of effort installing pre-R5 a couple of weeks ago I
> reverted back to my creaky barely-R4 from ages ago because I was so
> shocked that the most useful tool for feeling your way in a new
> installation was simply not there. It gives the impression of a very
> not-ready product, which is counter to the impression I get from you
> folks. 
> 
> I just checked back today after a couple of weeks to find a few packages
> updated on 15 Jan, but not findutils.

Yeah, I found & fixed this bug on my system, but still have a problem with
that package: /usr/bin/updatedb refers to /var/tmp/findutils-root/... 
instead of simply /..., which is clearly broken.  I had to fix that file by
hand, although I'm sure there is a 'correct' way of doing this.

The original problem stems from the fact that 'strdup' is reimplemented by the
package, but in a way that is uncompatible with the glibc2 header files.  I
made a non-optimal-but-working fix to this, just to get it working.

-igor

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
