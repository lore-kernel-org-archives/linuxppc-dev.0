From: kd@flaga.is
Subject: Re: Problem: Hangs on pthread_allocate_stack during pthread_create
To: Indra Gunawan Harijono <indragho1@yahoo.de>
Cc: linuxppc-dev@lists.linuxppc.org
Message-ID: <OF9F9FFAE0.7DE53A9B-ON002568B2.00559C94@flaga.is>
Date: Thu, 30 Mar 2000 15:39:10 +0000
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Yes I did and do have this problem. I have not seen any fix other than
replacing memset() with a for loop that clears the new_thread struct.

I have no Idea why this happens. I have not analysed the code that gcc
produces (version 2.95) but it might have problems with large structures,
the thread structure is around 0.5KB (500 bytes). But this is a pure guess.

K.D.





                    Indra Gunawan Harijono
                    <indragho1@yahoo.de>               To:     linuxppc-dev@lists.linuxppc.org
                    Sent by:                           cc:
                    owner-linuxppc-dev@lists.li        Subject:     Problem: Hangs on pthread_allocate_stack during pthread_create
                    nuxppc.org


                    30.03.2000 13:50







Hi,

Did someone have the problem, that pthread_create
hangs on function pthread_allocate_stack (exacly in
memset(new_thread,'\0'sizeof(*new_thread)) ?? this
happens without running with gdb etc, I just compiled
the programs under Examples and run them on the MPC86
board.

memset itself seems to work corrently (uses
glib-2.1.3/sysdep/powerpc/memset.S).

Unfortunately I do not have gdb on the board.

Following is the configuration, I uses:
Glibc-2.1.3,
powerpc running under MPC860,
gcc-2.95.2,

that I cross compiled under intel PC.


Can someone point me the sites how to build the gdb
for the board using the cross compiler?


I will appreciate, if one can give me hints or infos.

Thank you.


indra

Gesendet von Yahoo! Mail - http://mail.yahoo.de
Yahoo! Mail auf Ihrem Handy? - http://mobil.yahoo.de


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
