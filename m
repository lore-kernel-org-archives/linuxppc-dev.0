Date: Tue, 23 May 2000 21:16:42 -0500
Subject: partition size funkiness
From: Eric Peden <ericpeden@homemail.com>
To: LinuxPPC Dev <linuxppc-dev@lists.linuxppc.org>
Message-ID: <B550A5BA.464A%ericpeden@homemail.com>
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Note: this message was originally posted to the linuxppc-user list. I failed
to receive any fruitful responses, and am posting it here. I've added a few
additional comments after the original message.

-- Begin Original Message --
I have a 4gb disk that I'm currently using for Linux. The drive is split
into three main partitions: root, swap, and an HFS exchange (there's a
bootstrap, too, but it's not one of the main ones ;). Root is 2.7GB, but
when I use df to check drive usage, it reports it as only being 1.4GB. This
is obviously not desirable behavior. Anyone have any ideas as to what the
problem is? I've checked inodes (as suggested in the archives), but there
appear to be plenty.

My partition map (yes, I know there are some very inefficiently sized chunks
here; partitioning this drive was a learning experience for me, and I've yet
to correct my many mistakes with it):

> Partition map (with 512 byte blocks) on '/dev/sda'
> #:                type name                      length   base    ( size )
> 1: Apple_partition_map Apple                         63 @ 1
> 2:      Apple_Driver43*Macintosh                     54 @ 64
> 3:      Apple_Driver43*Macintosh                     64 @ 118
> 4:  Apple_Driver_IOKit Macintosh                    512 @ 182
> 5:       Apple_Patches Patch Partition              512 @ 694
> 6:           Apple_HFS MacOS/Preferred LinuxPPC 2097152 @ 1206    (  1.0G)
> 7:     Apple_UNIX_SVR2 /                        5529600 @ 2098358 (  2.6G)
> 8:     Apple_UNIX_SVR2 swap                      262144 @ 7627958 (128.0M)
> 9:     Apple_Bootstrap bootstrap                 204800 @ 7890102 (100.0M)
> 10:          Apple_Free Extra                     376328 @ 8094902 (183.8M)
> 11:          Apple_Free Extra                          2 @ 8471230
>
> Device block size=512, Number of Blocks=8471231 (4.0G)

Output of "df -ih"
> Filesystem            Inodes   IUsed   IFree IUse% Mounted on
> /dev/sda7               376k     79k    297k   21% /
> /dev/sda6                62k     41k     21k   66% /mnt/exchange

and "df -h"
> Filesystem            Size  Used Avail Use% Mounted on
> /dev/sda7             1.4G  1.1G  222M  84% /
> /dev/sda6             1.0G  679M  345M  66% /mnt/exchange

When I first set up this drive, I had separate root and /usr partitions, but
/usr quickly filled up while root stayed mostly empty. I backed up, merged,
and restored the two awhile back. Could I have introduced the problem during
this process?

Any help is greatly appreciated. I don't like having 1GB+ of unusable space
on my drive, especially since I'm trying to install several large programs
right now.
-- End Original Message --

I've begun to suspect that my problems are due to the method I used to
"re-partition" the drive; I simply used pdisk to re-arrange the partition
map, thus doing a non-destructive repartitioning. I've only managed to find
one mention of a problem similar to mine at:

http://slashdot.org/askslashdot/99/08/09/0315246.shtml

The cause is different, and of course no solution is offered, but the
symptoms are the same. Is partition information stored somewhere other than
the partition map? Is df just reading this information incorrectly, or is
the extra space on /dev/sda7 truly unusable? Is there some low-level
information I could modify to properly reflect the size of root?

Again, help is appreciated...

--eric


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
