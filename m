To: ARIBAUD Albert <a.aribaud@giat-industries.fr>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Lost+Found directory (was: self image) 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 11 Dec 2003 08:59:29 +0100."
             <158EF4B20EA8C84D9DC71A55216D2E1C066C5C@csy-exchange1.giat.intra>
Date: Thu, 11 Dec 2003 10:22:40 +0100
Message-Id: <20031211092245.BDD07C5F5F@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <158EF4B20EA8C84D9DC71A55216D2E1C066C5C@csy-exchange1.giat.intra> you wrote:
>
> > Your new filesystem is twice as big as the old one, so it  will  have
> > more inode blocks etc. Also, you may notice that our filesystem image
> > does not contain the (rather large) lost+found firectory.
>
> How come the lost+found directory is large, or even has a single entry
> to begin with? I thought it was used by fsck to collect file data lost
> due to file system corruption over time; so in a freshly built embedded
> image, there shouldn't be any of that. Did I miss something?

When the filesystem is created (by mke2fs) special care is  taken  to
create a big directory that allows for many entries to be reconnected
without  need  to  grow  the directory which could be dangerous on an
already corrupted filesystem. Have a look:

	# ls -l
	total 12
	drwx------    2 root     root        12288 Dec 11 10:14 lost+found
	# df .
	Filesystem           1K-blocks      Used Available Use% Mounted on
	/tmp/rd                  63461        13     63448   1% /mnt/tmp
	# rmdir lost+found/
	# df .
	Filesystem           1K-blocks      Used Available Use% Mounted on
	/tmp/rd                  63461         1     63460   1% /mnt/tmp

As you can see the "lost+found"  as  created  by  the  "mke2fs"  tool
occupies 12kB of filesystem space which get freed when you remove the
directory.

	# mkdir lost+found
	# ls -l
	total 1
	drwxr-xr-x    2 root     root         1024 Dec 11 10:15 lost+found
	# df .
	Filesystem           1K-blocks      Used Available Use% Mounted on
	/tmp/rd                  63461         2     63459   1% /mnt/tmp

If you manually create a directory it will occupy only 1 kB instead.

In older times you used to run something like
	for i in 0 1 2 3 4 5 6 7 8 9 ; do
	  for j in 0 1 2 3 4 5 6 7 8 9 ; do
	    for k in 0 1 2 3 4 5 6 7 8 9 ; do
	      touch lost+found/${i}${j}${k}
	done ; done ; done
	rm -f lost+found/*

to "blow up" the lost+found/ directory to allow  for  a  sufficiently
large   number   of   directory   entries.  Today  mke2fs  does  this
automagically (and people forget why it needs to be done).

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Why can you only have two doors on a chicken coop? If it had four  it
would be a chicken sedan.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
