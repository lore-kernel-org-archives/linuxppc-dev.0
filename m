Date: Thu, 11 Feb 1999 15:51:00 -0700 (MST)
From: Jeff Rugen <jrugen@primenet.com>
To: root <hughc@babcockbrown.com>
cc: linuxppc-user@lists.linuxppc.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: R5 Install (Mostly) Successful on PBG3
In-Reply-To: <36C33FEB.FDB02302@babcockbrown.com>
Message-ID: <Pine.BSI.3.96.990211154529.28495A-100000@usr09.primenet.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 11 Feb 1999, root wrote:

> There were a few failures during intstall.  The main problem I have is
> that RPM doesn't work; any attempt to use it returns an error
> "//var/lib/rpm/nameindex.rpm: Invalid argument"

The problem seems to be the R4 RPM database and the pre-R5 RPM database are
incompatible with each other.  I manually removed all the /var/lib/rmp/*
files (well, i copied them off) and reinstalled -- it created a new RPM
database that works.  However, I was left with a ton of files from R4 rpms,
that were no longer needed and I had to remove manually.

I did write a script that would return 0 if the file passed in as a name was
listed in the RPM database, and -1 otherwise, then used the script in a find
command to list all the non-RPM files.  I ran it overnight -- ended up with
thousands of files, and manually deleted large chunks of them. 

Be _very_ careful doing this.  Sometimes you'll get RPMs that don't indicate
that a directory is part of the distribution, so you'll see directory names
you think you can delete.  You don't want to do that. :-)

----------------------------------------------------------------------------
Jeff Rugen                      jrugen@primenet.com

...Had this been an actual emergency, we would have fled in terror, and you 
would not have been informed.


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
