Message-ID: <19990610122324.A82556@risc.sps.mot.com>
Date: Thu, 10 Jun 1999 12:23:24 -0500
From: Dave Wolfe <dwolfe@risc.sps.mot.com>
To: "Packer, Dave" <dPacker@uppercase.xerox.com>,
        "'linuxppc-dev@lists.linuxppc.org'" <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Wierd File Sizes....
References: <AF223B12F1FDD2119253006097C4FCEC05B163@cats.pdri.xerox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AF223B12F1FDD2119253006097C4FCEC05B163@cats.pdri.xerox.com>; from Packer, Dave on Thu, Jun 10, 1999 at 09:48:54AM -0700
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


[ Packer, Dave writes: ]
> 
> This is peculiar behavior I've never noticed before and was wondering if
> anyone else has experienced this.  I've created a file using mmap, set its
> size to the appropriate bytes, and then written it. As you can see in the
> listing below the file size is 156K, but du -k only sees 7K.  What's not
> below is if I use df -k it sees 7K less than before the file was created.

This is a feature. Unix file systems support sparse files. The
uninitialized blocks aren't allocated on disk, so du is reporting the
true file size, i.e. the disk space used to contain the file, vs the
offset of the EOF, which is what ls reports.

> As you can see below by using gzip / ungzip the file gets noticed properly.

Ungzip actually wrote the intervening blocks which didn't exist in the
original file, so now disk space is required to hold those blocks.
I believe tar has an option to accurately preserve sparse files, so
gzipping a tar of such files would be one way of compressing them if you
felt you really needed to do that.

-- 
 Dave Wolfe

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
