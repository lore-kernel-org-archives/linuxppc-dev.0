Message-ID: <3E52D37C.3010608@kegel.com>
Date: Tue, 18 Feb 2003 16:44:44 -0800
From: Dan Kegel <dank@kegel.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: Retrieving linuxppc_2_4_devel corresponding to 2.4.19?
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


What's the best way to retrieve linuxppc_2_4_devel as of
2.4.19?  Browsing through http://ppc.bkbits.net:8080/linuxppc_2_4_devel
I see that the right changeset appears to be 1.1091.1.23
(Lord only knows what those numbers mean):

 > ChangeSet@1.1091.1.23, 2002-08-03 16:26:58+10:00, paulus@samba.org
 >   Merge samba.org:/home/paulus/kernel/linuxppc_2_4
 >   into samba.org:/home/paulus/kernel/linuxppc_2_4_devel

The magic recipe we receved from the gods to retrieve that version is

ver=1.1091.1.23
bk clone -r$ver bk://ppc.bkserver.net/linuxppc_2_4_devel linuxppc_2_4_devel-$ver
cd linuxppc_2_4_devel-$ver
find . -type d -exec bk get {} \;
find . -name SCCS -print | xargs rm -rf
rm -rf RESYNC/
rm -rf PENDING/
rm -rf BitKeeper/
rm -f ChangeSet


That seems to work.  However, I'm a bit concerned for several reasons:
0. it looks pretty hacky
1. there's no label on the changeset in question
2. Tom Rini said:
   "... keep in mind that revision numbers are not constant, only TAGs,
     and keys.  Poking in the BK help should tell you how to go from
     a rev to a key, and then back."
So I'm afraid that magic 1.1091.1.23 is going to get renumbered
sometime, and I'll have no way to retrieve a 2.4.19 that
works on ppc405.  Poking around on bitkeeper.com's online
doc revealed no discussion of "keys", so I'm a bit mystified.

Can the list comment on the recipe I use to
retrieve a clean kernel source tree, and
on what the heck Tom Rini was talking about
with converting from a rev to a key and back?

Also, I see from the bitkeeper logs that linuxppc_2_4_devel
gets merged into from both linuxppc_2_4 and Linus's tree.
Am I right in assuming that I still want linuxppc_2_4_devel
for ppc405 support?

Thanks,
Dan

--
Dan Kegel
http://www.kegel.com
http://counter.li.org/cgi-bin/runscript/display-person.cgi?user=78045


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
