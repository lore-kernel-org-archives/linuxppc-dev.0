Message-Id: <AF223B12F1FDD2119253006097C4FCEC05B163@cats.pdri.xerox.com>
From: "Packer, Dave" <dPacker@uppercase.xerox.com>
To: "'linuxppc-dev@lists.linuxppc.org'" <linuxppc-dev@lists.linuxppc.org>
Subject: Wierd File Sizes....
Date: Thu, 10 Jun 1999 09:48:54 -0700
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



All,

This is peculiar behavior I've never noticed before and was wondering if
anyone else has experienced this.  I've created a file using mmap, set its
size to the appropriate bytes, and then written it. As you can see in the
listing below the file size is 156K, but du -k only sees 7K.  What's not
below is if I use df -k it sees 7K less than before the file was created.

Another wierd thing was that I ran this application last night on some very
large files and it created a 200MB index / df -k said I only had 160MB
before the file was written. du -k said the file was only a few 100K.

As you can see below by using gzip / ungzip the file gets noticed properly.

Anyone have any ideas about this bizarreness?

Dave-


Bauhaus:index> ls -la
total 13
drwxrwxr-x   2 davep    davep        5120 Jun 10 08:42 .
drwxrwxr-x   3 davep    davep        6144 Jun 10 08:42 ..
-rw-------   1 davep    davep      156418 Jun 10 08:42 index.256
Bauhaus:index> du -k
7       .
Bauhaus:index> gzip index.256 
Bauhaus:index> ls -la
total 76
drwxrwxr-x   2 davep    davep        5120 Jun 10 08:44 .
drwxrwxr-x   3 davep    davep        6144 Jun 10 08:42 ..
-rw-------   1 davep    davep       65142 Jun 10 08:42 index.256.gz
Bauhaus:index> du -k
70      .
Bauhaus:index> gunzip index.256.gz 
Bauhaus:index> ls -la
total 165
drwxrwxr-x   2 davep    davep        5120 Jun 10 08:44 .
drwxrwxr-x   3 davep    davep        6144 Jun 10 08:42 ..
-rw-------   1 davep    davep      156418 Jun 10 08:42 index.256
Bauhaus:index> du -k
159     .
Bauhaus:index> 


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
