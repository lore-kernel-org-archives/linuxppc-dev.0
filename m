Return-Path: <daniel.black@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xrJKQ4KQqzDrnV
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Sep 2017 16:43:22 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v8B6dlMj057609
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Sep 2017 02:43:20 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2cwc08c6c1-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Sep 2017 02:43:18 -0400
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <daniel.black@au1.ibm.com>;
 Mon, 11 Sep 2017 16:43:15 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v8B6fxWG35061890
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Sep 2017 16:41:59 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v8B6foeT004363
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Sep 2017 16:41:50 +1000
From: Daniel Black <daniel.black@au1.ibm.com>
Subject: Power8 host unusable after kvm VM guest suspended for 2+ mins with
 client networking traffic
To: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@ozlabs.org>
Date: Mon, 11 Sep 2017 16:41:58 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <5b90a5ba-0d66-6ab0-de4b-ca177b708029@au.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Further testing of
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1714859



root@p87:~# virsh start jenkins-ppc64
Domain jenkins-ppc64 started

root@p87:~# uname -a
Linux p87 4.13.0 #1 SMP Sun Sep 3 22:39:51 UTC 2017 ppc64le ppc64le
ppc64le GNU/Linux

root@p87:~# uptime
 14:09:29 up 7 min,  2 users,  load average: 0.60, 1.35, 0.76



$ ssh danielgb@p87
danielgb@p87:~$  sshfs ozlabs@jenkins-ppc64:/home/ozlabs jenkins-ppc64/
-o reconnect,idmap=user

$ mount
...
fusectl on /sys/fs/fuse/connections type fusectl (rw,relatime)
ozlabs@jenkins-ppc64:/home/ozlabs on /home/danielgb/jenkins-ppc64 type
fuse.sshfs (rw,nosuid,nodev,relatime,user_id=1003,group_id=1003)

danielgb@p87:~$ ls -la /home/danielgb/jenkins-ppc64
total 136
drwx------  1 danielgb ozlabs    4096 Sep  4 13:47 .
drwxr-xr-x 32 danielgb danielgb  4096 Sep 11 14:07 ..
-rw-------  1 danielgb ozlabs    6156 Aug 30 19:41 .bash_history
-rw-r--r--  1 danielgb ozlabs      18 Feb 10  2017 .bash_logout
-rw-r--r--  1 danielgb ozlabs     193 Feb 10  2017 .bash_profile
-rw-r--r--  1 danielgb ozlabs     231 Feb 10  2017 .bashrc
drwxrwxr-x  1 danielgb ozlabs    4096 Sep  4 15:22 build-mariadb-10.2
drwxrwxr-x  1 danielgb ozlabs    4096 Sep  4 15:22 .ccache
drwx------  1 danielgb ozlabs    4096 Sep  4 13:47 .config
-rw-rw-r--  1 danielgb ozlabs     156 Aug 30 15:47 .gitconfig
drwxrwxr-x  1 danielgb ozlabs    4096 Sep  4 15:13 mariadb-10.2
drwxrwxr-x  1 danielgb ozlabs    4096 Aug 30 12:28 p87
drwxrw----  1 danielgb ozlabs    4096 Aug 30 12:29 .pki
drwx------  1 danielgb ozlabs    4096 Sep  4 13:53 .ssh
-rwxrwxr-x  1 danielgb ozlabs   69584 Sep  1 11:40 test
-rw-rw-r--  1 danielgb ozlabs     405 Sep  1 11:40 test.c

danielgb@p87:~$ mkdir build-mariadb-out-of-tree
danielgb@p87:~$ cd build-mariadb-out-of-tree
danielgb@p87:~/build-mariadb-out-of-tree$ cmake
../jenkins-ppc64/mariadb-10.2/
-- Running cmake version 3.5.1
-- The C compiler identification is GNU 5.4.0
-- The CXX compiler identification is GNU 5.4.0
-- Check for working C compiler: /usr/bin/cc
-- Check for working C compiler: /usr/bin/cc --


-- Configuring done
-- Generating done
-- Build files have been written to:
/home/danielgb/build-mariadb-out-of-tree


danielgb@p87:~/build-mariadb-out-of-tree$ make -j 400
Scanning dependencies of target gen_lex_hash
Scanning dependencies of target sha256_password
Scanning dependencies of target INFO_SRC
Scanning dependencies of target abi_check
Scanning dependencies of target mytap
Scanning dependencies of target crc32-vpmsum
Scanning dependencies of target INFO_BIN
Scanning dependencies of target mariadb_config
Scanning dependencies of target hsclient



$ ssh root@p87
root@p87:~# virsh suspend jenkins-ppc64
Domain jenkins-ppc64 suspended


root@p87:~# ps -ef

...

danielgb  12533   6079  0 14:12 pts/2    00:00:00 make -j 400
danielgb  12536  12533  0 14:12 pts/2    00:00:00 make -f
CMakeFiles/Makefile2 all
danielgb  12565  12536  0 14:12 pts/2    00:00:00 make -f
storage/mroonga/vendor/groonga/lib/CMakeFiles/libgroonga.dir/build.make
storage/mroonga/vendor/groonga/lib/CMakeFiles/libgroonga.dir/depend
danielgb  12567  12536  0 14:12 pts/2    00:00:00 make -f
storage/rocksdb/CMakeFiles/rocksdblib.dir/build.make
storage/rocksdb/CMakeFiles/rocksdblib.dir/depend
danielgb  12617  12567  0 14:12 pts/2    00:00:00 /bin/sh -c cd
/home/danielgb/build-mariadb-out-of-tree && /usr/bin/cmake -E
cmake_depends "Unix Makefiles" /home/danielgb/jenkins-ppc64/mariadb-10.2
/home/danielgb/jenkins-ppc6
danielgb  12619  12565  0 14:12 pts/2    00:00:00 /bin/sh -c cd
/home/danielgb/build-mariadb-out-of-tree && /usr/bin/cmake -E
cmake_depends "Unix Makefiles" /home/danielgb/jenkins-ppc64/mariadb-10.2
/home/danielgb/jenkins-ppc6
danielgb  12624  12617  0 14:12 pts/2    00:00:00 /usr/bin/cmake -E
cmake_depends Unix Makefiles /home/danielgb/jenkins-ppc64/mariadb-10.2
/home/danielgb/jenkins-ppc64/mariadb-10.2/storage/rocksdb
/home/danielgb/build-mariadb-
danielgb  12633  12619  0 14:12 pts/2    00:00:00 /usr/bin/cmake -E
cmake_depends Unix Makefiles /home/danielgb/jenkins-ppc64/mariadb-10.2
/home/danielgb/jenkins-ppc64/mariadb-10.2/storage/mroonga/vendor/groonga/lib
/home/dani
danielgb  13068  12536  0 14:12 pts/2    00:00:00 make -f
sql/CMakeFiles/gen_lex_hash.dir/build.make
sql/CMakeFiles/gen_lex_hash.dir/build
danielgb  13082  12536  0 14:12 pts/2    00:00:00 make -f
unittest/mytap/CMakeFiles/mytap.dir/build.make
unittest/mytap/CMakeFiles/mytap.dir/build
danielgb  13086  13068  0 14:12 pts/2    00:00:00 /bin/sh -c cd
/home/danielgb/build-mariadb-out-of-tree/sql && /usr/bin/c++
-DHAVE_CONFIG_H -DHAVE_EVENT_SCHEDULER -DHAVE_OPENSSL
-DHAVE_POOL_OF_THREADS -DHAVE_SYSTEMD -DMYSQL
danielgb  13087  13086  0 14:12 pts/2    00:00:00 /usr/bin/c++
-DHAVE_CONFIG_H -DHAVE_EVENT_SCHEDULER -DHAVE_OPENSSL
-DHAVE_POOL_OF_THREADS -DHAVE_SYSTEMD -DMYSQL_SERVER
-D_FILE_OFFSET_BITS=64 -I/home/danielgb/build-mariadb-ou
danielgb  13089  13087  0 14:12 pts/2    00:00:00
/usr/lib/gcc/powerpc64le-linux-gnu/5/cc1plus -quiet -I
/home/danielgb/build-mariadb-out-of-tree/include -I
/home/danielgb/jenkins-ppc64/mariadb-10.2/include -I /home/danielgb/j
danielgb  13091  13082  0 14:12 pts/2    00:00:00 /bin/sh -c cd
/home/danielgb/build-mariadb-out-of-tree/unittest/mytap && /usr/bin/cc
-DHAVE_CONFIG_H -DHAVE_SYSTEMD -D_FILE_OFFSET_BITS=64
-I/home/danielgb/build-mariadb-out-o
danielgb  13092  13091  0 14:12 pts/2    00:00:00 /usr/bin/cc
-DHAVE_CONFIG_H -DHAVE_SYSTEMD -D_FILE_OFFSET_BITS=64
-I/home/danielgb/build-mariadb-out-of-tree/include
-I/home/danielgb/jenkins-ppc64/mariadb-10.2/include -pie -f
danielgb  13093  13092  0 14:12 pts/2    00:00:00
/usr/lib/gcc/powerpc64le-linux-gnu/5/cc1 -quiet -I
/home/danielgb/build-mariadb-out-of-tree/include -I
/home/danielgb/jenkins-ppc64/mariadb-10.2/include -imultiarch powerpc64le


root@p87:~# killall -9 cc1
root@p87:~#



console started to display:

      Tainted: G        W       4.13.0 #1
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
INFO: task cc1plus:13132 blocked for more than 120 seconds.
      Tainted: G        W       4.13.0 #1
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
INFO: task cc1plus:13135 blocked for more than 120 seconds.
      Tainted: G        W       4.13.0 #1
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
INFO: task cc1plus:13136 blocked for more than 120 seconds.
      Tainted: G        W       4.13.0 #1
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
INFO: task cc1plus:13137 blocked for more than 120 seconds.
      Tainted: G        W       4.13.0 #1
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
INFO: task cc1plus:13138 blocked for more than 120 seconds.
      Tainted: G        W       4.13.0 #1
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
INFO: task cc1:13492 blocked for more than 120 seconds.
      Tainted: G        W       4.13.0 #1
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
INFO: task cc1:13512 blocked for more than 120 seconds.
      Tainted: G        W       4.13.0 #1
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
Watchdog CPU:88 detected Hard LOCKUP other CPUS:32,112

root@p87:~#
root@p87:~#
root@p87:~#
root@p87:~# INFO: rcu_sched detected stalls on CPUs/tasks:
        32-...: (16 GPs behind) idle=516/140000000000000/0
softirq=5332/5334 fqs=1159
        112-...: (2 GPs behind) idle=6ca/140000000000000/0
softirq=5150/5150 fqs=1159
        (detected by 144, t=2602 jiffies, g=3997, c=3996, q=5353)
Watchdog CPU:56 Hard LOCKUP
Watchdog CPU:56 became unstuck
atchdog CPU:144 became unstuck
INFO: rcu_sched detected stalls on CPUs/tasks:
        32-...: (16 GPs behind) idle=516/140000000000000/0
softirq=5332/5334 fqs=3697
        112-...: (2 GPs behind) idle=6ca/140000000000000/0
softirq=5150/5150 fqs=3697
        (detected by 0, t=10407 jiffies, g=3997, c=3996, q=9984)
Watchdog CPU:64 Hard LOCKUP
Watchdog CPU:64 became unstuck
Watchdog CPU:144 detected Hard LOCKUP other CPUS:0
rcu_sched kthread starved for 2211 jiffies! g3997 c3996 f0x0
RCU_GP_DOING_FQS(4) ->state=0x0
Watchdog CPU:64 Hard LOCKUP
Watchdog CPU:64 became unstuck
Watchdog CPU:0 became unstuck
sd 0:2:2:0: [sdc] tag#4 Resetting device

ipr 0001:08:00.0: Timed out waiting for aborted commands
sd 0:2:3:0: [sdd] tag#2 Resetting device
INFO: rcu_sched detected stalls on CPUs/tasks:
        32-...: (16 GPs behind) idle=516/140000000000000/0
softirq=5332/5334 fqs=6176
        112-...: (2 GPs behind) idle=6ca/140000000000000/0
softirq=5150/5150 fqs=6176
        (detected by 184, t=18212 jiffies, g=3997, c=3996, q=14373)
Watchdog CPU:64 Hard LOCKUP
Watchdog CPU:64 became unstuck
Watchdog CPU:168 detected Hard LOCKUP other CPUS:184
ipr 0001:08:00.0: Timed out waiting for aborted commands
sr 0:0:9:0: tag#1 Resetting device
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 t0
ata1.00: cmd a0/00:00:00:08:00/00:00:00:00:00/a0 tag 5 pio 16392 in
         Get event status notification 4a 01 00 00 10 00 00 00 08 00res
40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata1.00: status: { DRDY }
rcu_sched kthread starved for 2209 jiffies! g3997 c3996 f0x0
RCU_GP_DOING_FQS(4) ->state=0x0
Watchdog CPU:64 Hard LOCKUP
Watchdog CPU:64 became unstuck
Watchdog CPU:184 became unstuck

ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 t0
ata1.00: cmd a0/00:00:00:08:00/00:00:00:00:00/a0 tag 5 pio 16392 in
         Get event status notification 4a 01 00 00 10 00 00 00 08 00res
40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata1.00: status: { DRDY }
rcu_sched kthread starved for 2209 jiffies! g3997 c3996 f0x0
RCU_GP_DOING_FQS(4) ->state=0x0
Watchdog CPU:64 Hard LOCKUP
Watchdog CPU:64 became unstuck
Watchdog CPU:184 became unstuck
ipr 0001:08:00.0: Timed out waiting for aborted commands
INFO: rcu_sched detected stalls on CPUs/tasks:
        32-...: (16 GPs behind) idle=516/140000000000000/0
softirq=5332/5334 fqs=8679
        112-...: (2 GPs behind) idle=6ca/140000000000000/0
softirq=5150/5150 fqs=8679
        (detected by 176, t=26017 jiffies, g=3997, c=3996, q=18223)
Watchdog CPU:168 detected Hard LOCKUP other CPUS:176
rcu_sched kthread starved for 2209 jiffies! g3997 c3996 f0x0
RCU_GP_DOING_FQS(4) ->state=0x0
Watchdog CPU:88 Hard LOCKUP
Watchdog CPU:88 became unstuck
Watchdog CPU:176 became unstuck
INFO: rcu_sched detected stalls on CPUs/tasks:
        32-...: (16 GPs behind) idle=516/140000000000000/0
softirq=5332/5334 fqs=11184
        112-...: (2 GPs behind) idle=6ca/140000000000000/0
softirq=5150/5150 fqs=11184
        (detected by 96, t=33822 jiffies, g=3997, c=3996, q=22657)
Watchdog CPU:88 Hard LOCKUP
Watchdog CPU:88 became unstuck
Watchdog CPU:176 detected Hard LOCKUP other CPUS:96
rcu_sched kthread starved for 2209 jiffies! g3997 c3996 f0x0
RCU_GP_DOING_FQS(4) ->state=0x0
Watchdog CPU:88 Hard LOCKUP
Watchdog CPU:88 became unstuck
Watchdog CPU:96 became unstuck
INFO: rcu_sched detected stalls on CPUs/tasks:
        32-...: (16 GPs behind) idle=516/140000000000000/0
softirq=5332/5334 fqs=13686
        112-...: (2 GPs behind) idle=6ca/140000000000000/0
softirq=5150/5150 fqs=13686
        (detected by 96, t=41627 jiffies, g=3997, c=3996, q=27054)
Watchdog CPU:56 Hard LOCKUP
Watchdog CPU:56 became unstuck
Watchdog CPU:56 Hard LOCKUP
rcu_sched kthread starved for 2209 jiffies! g3997 c3996 f0x0
RCU_GP_DOING_FQS(4) ->state=0x0
Watchdog CPU:56 became unstuck
INFO: rcu_sched detected stalls on CPUs/tasks:
        32-...: (16 GPs behind) idle=516/140000000000000/0
softirq=5332/5334 fqs=16173
        112-...: (2 GPs behind) idle=6ca/140000000000000/0
softirq=5150/5150 fqs=16173
        (detected by 160, t=49432 jiffies, g=3997, c=3996, q=31400)
Watchdog CPU:56 Hard LOCKUP
Watchdog CPU:56 became unstuck
rcu_sched kthread starved for 2210 jiffies! g3997 c3996 f0x0
RCU_GP_DOING_FQS(4) ->state=0x0
Watchdog CPU:56 Hard LOCKUP
Watchdog CPU:56 became unstuck
Watchdog CPU:160 Hard LOCKUP
Watchdog CPU:160 became unstuck
INFO: rcu_sched detected stalls on CPUs/tasks:
        32-...: (16 GPs behind) idle=516/140000000000000/0
softirq=5332/5334 fqs=18704
        112-...: (2 GPs behind) idle=6ca/140000000000000/0
softirq=5150/5150 fqs=18704
        (detected by 80, t=57237 jiffies, g=3997, c=3996, q=36054)







test with x86_64 as the client:


ozlabs@ka5:~$ uname -a
Linux ka5 4.13.0-svaidy+ #6 SMP Thu Sep 7 08:41:39 IST 2017 x86_64
x86_64 x86_64 GNU/Linux



p87 login: root
Password:
Last login: Mon Sep 11 14:11:51 AEST 2017 from 10.61.2.139 on pts/3
Welcome to Ubuntu 16.04.2 LTS (GNU/Linux 4.13.0 ppc64le)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage
root@p87:~# virsh start jenkins-ppc64

Domain jenkins-ppc64 started

root@p87:~#
root@p87:~# virsh list
 Id    Name                           State
----------------------------------------------------
 1     jenkins                        running
 2     jenkins-ppc64                  running




ozlabs@ka5:~$   sshfs ozlabs@jenkins-ppc64:/home/ozlabs jenkins-ppc64/
ozlabs@jenkins-ppc64's password:

ozlabs@ka5:~$  mkdir build-mariadb-out-of-tree
ozlabs@ka5:~$  cd build-mariadb-out-of-tree
ozlabs@ka5:~/build-mariadb-out-of-tree$  cmake
../jenkins-ppc64/mariadb-10.2/
-- Running cmake version 3.5.1
-- The C compiler identification is GNU 5.4.1
-- The CXX compiler identification is GNU 5.4.1
-- Check for working C compiler: /usr/bin/cc
-- Check for working C compiler: /usr/bin/cc -- works
-- Detecting C compiler ABI info
-- Detecting C compiler ABI info - done
-- Detecting C compile features

-- Configuring done
-- Generating done
-- Build files have been written to: /home/ozlabs/build-mariadb-out-of-tree
ozlabs@ka5:~/build-mariadb-out-of-tree$
ozlabs@ka5:~/build-mariadb-out-of-tree$ make -j 300



root@p87:~# virsh suspend jenkins-ppc64
Domain jenkins-ppc64 suspended


ssh ozlabs@ka5
ozlabs@ka5:~$ ps -ef

ozlabs   22623 22615  0 14:40 pts/0    00:00:00 /usr/bin/cc
-DHAVE_CONFIG_H -DNO_KILL_INTR -D_FILE_OFFSET_BITS=64
-I/home/ozlabs/build-mariadb-out-of-tree/include
-I/home/ozlabs/jenkins-ppc64/mariadb-10.2/include -I/home/ozlab
ozlabs   22624 22618  0 14:40 pts/0    00:00:00
/usr/lib/gcc/x86_64-linux-gnu/5/cc1 -quiet -I
/home/ozlabs/build-mariadb-out-of-tree/include -I
/home/ozlabs/jenkins-ppc64/mariadb-10.2/include -I
/home/ozlabs/jenkins-ppc64/mari
ozlabs   22625 22617  0 14:40 pts/0    00:00:00 /usr/bin/cc
-DHAVE_CONFIG_H -DNO_KILL_INTR -D_FILE_OFFSET_BITS=64
-I/home/ozlabs/build-mariadb-out-of-tree/include
-I/home/ozlabs/jenkins-ppc64/mariadb-10.2/include -I/home/ozlab
ozlabs   22626 22623  0 14:40 pts/0    00:00:00
/usr/lib/gcc/x86_64-linux-gnu/5/cc1 -quiet -I
/home/ozlabs/build-mariadb-out-of-tree/include -I
/home/ozlabs/jenkins-ppc64/mariadb-10.2/include -I
/home/ozlabs/jenkins-ppc64/mari
ozlabs   22627 22622  0 14:40 pts/0    00:00:00
/usr/lib/gcc/x86_64-linux-gnu/5/cc1 -quiet -I
/home/ozlabs/build-mariadb-out-of-tree/include -I
/home/ozlabs/jenkins-ppc64/mariadb-10.2/include -I
/home/ozlabs/jenkins-ppc64/mari
ozlabs   22628 22621  0 14:40 pts/0    00:00:00 /usr/bin/cc
-DHAVE_CONFIG_H -DNO_KILL_INTR -D_FILE_OFFSET_BITS=64
-I/home/ozlabs/build-mariadb-out-of-tree/include
-I/home/ozlabs/jenkins-ppc64/mariadb-10.2/include -I/home/ozlab
ozlabs   22629 22625  0 14:40 pts/0    00:00:00
/usr/lib/gcc/x86_64-linux-gnu/5/cc1 -quiet -I
/home/ozlabs/build-mariadb-out-of-tree/include -I
/home/ozlabs/jenkins-ppc64/mariadb-10.2/include -I
/home/ozlabs/jenkins-ppc64/mari
ozlabs   22630 22628  0 14:40 pts/0    00:00:00
/usr/lib/gcc/x86_64-linux-gnu/5/cc1 -quiet -I
/home/ozlabs/build-mariadb-out-of-tree/include -I
/home/ozlabs/jenkins-ppc64/mariadb-10.2/include -I
/home/ozlabs/jenkins-ppc64/mari
ozlabs   27527 12443  3 14:40 pts/1    00:00:00 -bash
ozlabs   27541 27527  0 14:40 pts/1    00:00:00 ps -ef

ozlabs@ka5:~$ killall -9 cc1
ozlabs@ka5:~$

ozlabs@ka5:~$ date
Monday 11 September  14:41:57 AEST 2017


ozlabs@ka5:~$ date
Monday 11 September  14:45:44 AEST 2017

(console errors began at this point)...



(note ipr 0001:08:00.0 failure is known).


Watchdog CPU:88 detected Hard LOCKUP other CPUS:184


watchdog: BUG: soft lockup - CPU#168 stuck for 22s!
[qemu-system-ppc:5579]


INFO: rcu_sched self-detected stall on CPU



INFO: rcu_sched self-detected stall on CPU



INFO: rcu_sched self-detected stall on CPU









INFO: rcu_sched detected stalls on CPUs/tasks:



Watchdog CPU:136 Hard LOCKUP



watchdog: BUG: soft lockup - CPU#88 stuck for 22s!
[qemu-system-ppc:5558]


Watchdog CPU:48 detected Hard LOCKUP other CPUS:16,88,96,168



Watchdog CPU:88 Hard LOCKUP



Watchdog CPU:168 Hard LOCKUP



Watchdog CPU:8 Hard LOCKUP



Watchdog CPU:40 detected Hard LOCKUP other CPUS:24



watchdog: BUG: soft lockup - CPU#24 stuck for 23s! [rcu_sched:9]




Watchdog CPU:24 became unstuck





sr 0:0:9:0: tag#0 Resetting device



ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 t0



ata1.00: cmd a0/00:00:00:08:00/00:00:00:00:00/a0 tag 12 pio 16392 in



         Get event status notification 4a 01 00 00 10 00 00 00 08 00res
40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)


ata1.00: status: { DRDY }



watchdog: BUG: soft lockup - CPU#96 stuck for 21s! [ksmd:1695]




Watchdog CPU:24 Hard LOCKUP




Watchdog CPU:24 became unstuck



rcu_sched kthread starved for 1049 jiffies! g1772 c1771 f0x0
RCU_GP_DOING_FQS(4) ->state=0x0


Watchdog CPU:24 Hard LOCKUP



Watchdog CPU:24 became unstuck



Watchdog CPU:8 became unstuck



watchdog: BUG: soft lockup - CPU#136 stuck for 22s!
[qemu-system-ppc:5556]


watchdog: BUG: soft lockup - CPU#16 stuck for 22s!
[qemu-system-ppc:5587]


ipr 0001:08:00.0: Timed out waiting for aborted commands



ata1: translated ATA stat/err 0x80/00 to SCSI SK/ASC/ASCQ 0xb/47/00



INFO: rcu_sched self-detected stall on CPU





INFO: rcu_sched self-detected stall on CPU



INFO: rcu_sched self-detected stall on CPU







INFO: rcu_sched detected stalls on CPUs/tasks:






Watchdog CPU:24 Hard LOCKUP



Watchdog CPU:24 became unstuck



Watchdog CPU:104 detected Hard LOCKUP other CPUS:80



Watchdog CPU:104 detected Hard LOCKUP other CPUS:24




watchdog: BUG: soft lockup - CPU#24 stuck for 21s! [rcu_sched:9]




Watchdog CPU:24 became unstuck



ipr 0001:08:00.0: FFF4: Disk device problem



ipr: -----Failing Device Information-----



ipr: World Wide Unique ID: 5000C5007E890B2B0000000000000000



ipr: Device Resource Path: 00-02



ipr: Primary Problem Description:



ipr: Secondary Problem Description:



ipr: SCSI Sense Data:



ipr: 00000000: 70000200 00000018 00000000 04000000



ipr: 00000010: 00000000 00000000 00000000 00000000



ipr: SCSI Command Descriptor Block:



ipr: 00000000: FFFFFFFF FFFFFFFF FFFFFFFF FFFFFFFF



ipr: Additional IOA Data:



ipr: 00000000: 455300CC 05B00007 00000000 84000020



ipr: 00000010: 00000000 00000000 0B7EAFC0 00000000



ipr: 00000020: 00000000 0B7EA8A0 C8008000 00000000



ipr: 00000030: 00000000 00000000 00000480 8F000000



ipr: 00000040: 000D8949 00000000 00000000 00000000



ipr: 00000050: 00000000 00000000 00000000 00000000



ipr: 00000060: 00000000 00000000 00000000 00000000



ipr: 00000070: 00000000 00000000 00000000 00000000



ipr: 00000080: 00000000 D4000001 80000000 FFFFFFFF



ipr: 00000090: FFFFFFFF 00000000 002693B0 00000000



ipr: 000000A0: 00000000 00000000 01827424 00000000



ipr: 000000B0: 01B04AC0 E0030000 E0000060 04448502



ipr: 000000C0: 00000000 1B000000 01000000 00000000



ipr: 000000D0: 43440010 1B000000 01000000 00000000



ipr: 000000E0: 00000000 45480040 11001E01 1B000000



ipr: 000000F0: 04440000 D4000001 050B1E01 1B000000



ipr: 00000100: 01440000 D4000001 02021E91 1B000000



ipr: 00000110: 04448500 02040000 01001E91 00000000



ipr: 00000120: 04448500 02040000 45540004 000027B7



ipr: 00000130: 43490018 00000002 0002FFFF FFFFFFFF



ipr: 00000140: 5000C500 7E890B29 00001770 545209C0



ata1: translated ATA stat/err 0x00/00 to SCSI SK/ASC/ASCQ 0xb/00/00



watchdog: BUG: soft lockup - CPU#16 stuck for 23s!
[qemu-system-ppc:5587]


sr 0:0:9:0: tag#0 Resetting device



ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 t0



ata1.00: cmd a0/00:00:00:00:00/00:00:00:00:00/a0 tag 14



         Test Unit Ready 00 00 00 00 00 00res
40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)


ata1.00: status: { DRDY }



rcu_sched kthread starved for 1003 jiffies! g1772 c1771 f0x0
RCU_GP_DOING_FQS(4) ->state=0x0


Watchdog CPU:24 Hard LOCKUP



Watchdog CPU:24 became unstuck



Watchdog CPU:80 became unstuck



watchdog: BUG: soft lockup - CPU#96 stuck for 23s! [ksmd:1695]




root@p87:~# watchdog: BUG: soft lockup - CPU#136 stuck for 21s!
[qemu-system-ppc:5556]


watchdog: BUG: soft lockup - CPU#32 stuck for 23s! [java:5798]



ipr 0001:08:00.0: Timed out waiting for aborted commands



watchdog: BUG: soft lockup - CPU#40 stuck for 22s! [java:5799]



watchdog: BUG: soft lockup - CPU#152 stuck for 23s! [java:5770]



ata1: translated ATA stat/err 0x80/00 to SCSI SK/ASC/ASCQ 0xb/47/00



INFO: rcu_sched self-detected stall on CPU



INFO: rcu_sched self-detected stall on CPU



INFO: rcu_sched self-detected stall on CPU









INFO: rcu_sched detected stalls on CPUs/tasks:



Watchdog CPU:176 Hard LOCKUP




Watchdog CPU:24 Hard LOCKUP



Watchdog CPU:24 became unstuck



INFO: task kworker/u386:0:302 blocked for more than 120 seconds.



      Tainted: G        W    L  4.13.0 #1



"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this
message.


INFO: task kworker/0:1:1165 blocked for more than 120 seconds.



      Tainted: G        W    L  4.13.0 #1



"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this
message.


INFO: task khugepaged:1696 blocked for more than 120 seconds.



      Tainted: G        W    L  4.13.0 #1



"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this
message.


INFO: task md0_raid1:3300 blocked for more than 120 seconds.



      Tainted: G        W    L  4.13.0 #1



"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this
message.


INFO: task md2_raid10:3318 blocked for more than 120 seconds.



      Tainted: G        W    L  4.13.0 #1



"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this
message.


INFO: task xfsaild/md0:3498 blocked for more than 120 seconds.



      Tainted: G        W    L  4.13.0 #1



"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this
message.


INFO: task xfsaild/md2:4052 blocked for more than 120 seconds.



      Tainted: G        W    L  4.13.0 #1



"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this
message.


INFO: task qemu-system-ppc:5909 blocked for more than 120 seconds.



      Tainted: G        W    L  4.13.0 #1



"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this
message.


INFO: task qemu-system-ppc:5916 blocked for more than 120 seconds.



      Tainted: G        W    L  4.13.0 #1



"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this
message.


INFO: task qemu-system-ppc:5922 blocked for more than 120 seconds.



      Tainted: G        W    L  4.13.0 #1



"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this
message.



Watchdog CPU:80 Hard LOCKUP



Watchdog CPU:80 became unstuck




ipr 0001:08:00.0: FFF4: Disk device problem



ipr: -----Failing Device Information-----



ipr: World Wide Unique ID: 5000C5007E890B2B0000000000000000



ipr: Device Resource Path: 00-02



ipr: Primary Problem Description:



ipr: Secondary Problem Description:



ipr: SCSI Sense Data:



ipr: 00000000: 70000200 00000018 00000000 04000000



ipr: 00000010: 00000000 00000000 00000000 00000000



ipr: SCSI Command Descriptor Block:



ipr: 00000000: FFFFFFFF FFFFFFFF FFFFFFFF FFFFFFFF



ipr: Additional IOA Data:



ipr: 00000000: 455300CC 06B00007 00000000 84000020



ipr: 00000010: 00000000 00000000 0B7E1FC0 00000000



ipr: 00000020: 00000000 0B7E18A0 C8008000 00000000



ipr: 00000030: 00000000 00000000 00000580 8F000000



ipr: 00000040: 00178848 00000000 00000000 00000000



ipr: 00000050: 00000000 00000000 00000000 00000000



ipr: 00000060: 00000000 00000000 00000000 00000000



ipr: 00000070: 00000000 00000000 00000000 00000000



ipr: 00000080: 00000000 D4000001 80000000 FFFFFFFF



ipr: 00000090: FFFFFFFF 00000000 0026902D 00000000



ipr: 000000A0: 00000000 00000000 01827224 00000000



ipr: 000000B0: 01B04AC0 E0030000 E0000060 04448502



ipr: 000000C0: 00000000 1B000000 01000000 00000000



ipr: 000000D0: 43440010 1B000000 01000000 00000000



ipr: 000000E0: 00000000 45480050 11001E01 1B000000



ipr: 000000F0: 04440000 D4000001 060A1E01 1B000000



ipr: 00000100: 01440000 D4000001 03021E91 1B000000



ipr: 00000110: 04448500 02040000 02001E91 00000000



ipr: 00000120: 04448500 02040000 01001EB8 00000000



ipr: 00000130: 01440000 06290300 45540004 000027DE



ipr: 00000140: 43490018 00000002 0002FFFF FFFFFFFF



ipr: 00000150: 5000C500 7E890B29 00001770 545209C0



ipr 0001:08:00.0: Adapter being reset as a result of error recovery.




root@p87:~# ipr 0001:08:00.0: Dump of IOA initiated



Watchdog CPU:80 Hard LOCKUP



Watchdog CPU:80 became unstuck




Watchdog CPU:80 Hard LOCKUP




Watchdog CPU:80 became unstuck



watchdog: BUG: soft lockup - CPU#136 stuck for 22s!
[qemu-system-ppc:5556]


ipr 0001:08:00.0: Dump of IOA completed.



rcu_sched kthread starved for 1101 jiffies! g1772 c1771 f0x0
RCU_GP_DOING_FQS(4) ->state=0x0


Watchdog CPU:80 Hard LOCKUP



Watchdog CPU:80 became unstuck



Watchdog CPU:176 became unstuck



watchdog: BUG: soft lockup - CPU#96 stuck for 22s! [ksmd:1695]



watchdog: BUG: soft lockup - CPU#16 stuck for 23s!
[qemu-system-ppc:5587]


INFO: rcu_sched self-detected stall on CPU



INFO: rcu_sched self-detected stall on CPU



INFO: rcu_sched self-detected stall on CPU









INFO: rcu_sched detected stalls on CPUs/tasks:



ipr 0001:08:00.0: FFF4: Disk device problem



ipr: -----Failing Device Information-----



ipr: World Wide Unique ID: 5000C5007E890B2B0000000000000000



ipr: Device Resource Path: 00-02



ipr: Primary Problem Description:



ipr: Secondary Problem Description:



ipr: SCSI Sense Data:



ipr: 00000000: 70000200 00000018 00000000 04000000



ipr: 00000010: 00000000 00000000 00000000 00000000



ipr: SCSI Command Descriptor Block:



ipr: 00000000: FFFFFFFF FFFFFFFF FFFFFFFF FFFFFFFF



ipr: Additional IOA Data:



ipr: 00000000: 455300CC 06B00007 00000000 84000020



ipr: 00000010: 00000000 00000000 0B7DD7C0 00000000



ipr: 00000020: 00000000 0B7DD0A0 C8008000 00000000
ipr: 00000030: 00000000 00000000 00000580 8F000000
ipr: 00000040: 00199E3E 00000000 00000000 00000000
ipr: 00000050: 00000000 00000000 00000000 00000000
ipr: 00000060: 00000000 00000000 00000000 00000000
ipr: 00000070: 00000000 00000000 00000000 00000000
ipr: 00000080: 00000000 D4000001 80000000 FFFFFFFF
ipr: 00000090: FFFFFFFF 00000000 00267D4C 00000000
ipr: 000000A0: 00000000 00000000 01827224 00000000
ipr: 000000B0: 01B04AC0 E0030000 E0000060 04448502
ipr: 000000C0: 00000000 1B000000 01000000 00000000
ipr: 000000D0: 43440010 1B000000 01000000 00000000
ipr: 000000E0: 00000000 45480050 11001E01 1B000000
ipr: 000000F0: 04440000 D4000001 060A1E01 1B000000
ipr: 00000100: 01440000 D4000001 03021E91 1B000000
ipr: 00000110: 04448500 02040000 02001E91 00000000
ipr: 00000120: 04448500 02040000 01001EB8 00000000
ipr: 00000130: 01440000 06290300 45540004 000027E0
ipr: 00000140: 43490018 00000002 0002FFFF FFFFFFFF
ipr: 00000150: 5000C500 7E890B29 00001770 545209C0
ata1: translated ATA stat/err 0x00/00 to SCSI SK/ASC/ASCQ 0xb/00/00
Watchdog CPU:80 Hard LOCKUP
Watchdog CPU:80 became unstuck
Watchdog CPU:24 detected Hard LOCKUP other CPUS:8
sr 0:0:9:0: tag#0 Resetting device
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 t0
ata1.00: cmd a0/01:00:00:00:00/00:00:00:00:00/a0 tag 16 dma 96 in
         Test Unit Ready 00 00 00 00 00 00res
40/00:03:00:00:00/00:00:00:00:00/a0 Emask 0x4 (timeout)
ata1.00: status: { DRDY }
        16-...: (17084 ticks this GP) idle=a5a/140000000000001/0
softirq=2650/2650 fqs=5008
Watchdog CPU:80 Hard LOCKUP
Watchdog CPU:80 became unstuck
        96-...: (19396 ticks this GP) idle=e5e/140000000000001/0
softirq=4303/4303 fqs=5008
        136-...: (19398 ticks this GP) idle=c32/140000000000000/0
softirq=1602/1602 fqs=5008
Watchdog CPU:176 detected Hard LOCKUP other CPUS:32
Watchdog CPU:32 Hard LOCKUP
        184-...: (1 GPs behind) idle=d3a/140000000000001/0
softirq=677/677 fqs=5008
Watchdog CPU:80 Hard LOCKUP

Watchdog CPU:80 became unstuck
watchdog: BUG: soft lockup - CPU#136 stuck for 23s! [qemu-system-ppc:5556]
Watchdog CPU:80 Hard LOCKUP
Watchdog CPU:80 became unstuck
ipr 0001:08:00.0: Timed out waiting for aborted commands
ata1: translated ATA stat/err 0x80/00 to SCSI SK/ASC/ASCQ 0xb/47/00
rcu_sched kthread starved for 1100 jiffies! g1772 c1771 f0x0
RCU_GP_DOING_FQS(4) ->state=0x0
Watchdog CPU:80 Hard LOCKUP
Watchdog CPU:80 became unstuck
Watchdog CPU:8 became unstuck
watchdog: BUG: soft lockup - CPU#96 stuck for 21s! [ksmd:1695]
watchdog: BUG: soft lockup - CPU#16 stuck for 21s! [qemu-system-ppc:5587]
INFO: rcu_sched self-detected stall on CPU
INFO: rcu_sched self-detected stall on CPU
INFO: rcu_sched self-detected stall on CPU
        136-...: (24997 ticks this GP) idle=c32/140000000000001/0
softirq=1602/1602 fqs=5998

        16-...: (20474 ticks this GP) idle=a5a/140000000000001/0
softirq=2650/2650 fqs=5998

        96-...: (23892 ticks this GP) idle=e5e/140000000000001/0
softirq=4303/4303 fqs=5998
         (t=33821 jiffies g=1772 c=1771 q=19765)
INFO: rcu_sched detected stalls on CPUs/tasks:
        16-...: (20474 ticks this GP) idle=a5a/140000000000001/0
softirq=2650/2650 fqs=5999
Watchdog CPU:80 Hard LOCKUP
Watchdog CPU:80 became unstuck
Watchdog CPU:80 detected Hard LOCKUP other CPUS:24
        96-...: (23892 ticks this GP) idle=e5e/140000000000001/0
softirq=4303/4303 fqs=5999
Watchdog CPU:80 Hard LOCKUP
Watchdog CPU:80 became unstuck
        136-...: (24997 ticks this GP) idle=c32/140000000000001/0
softirq=1602/1602 fqs=5999
Watchdog CPU:80 Hard LOCKUP
Watchdog CPU:80 became unstuck
Watchdog CPU:80 Hard LOCKUP
Watchdog CPU:80 became unstuck
        184-...: (1 GPs behind) idle=d3a/140000000000001/0
softirq=677/677 fqs=6001
Watchdog CPU:80 Hard LOCKUP

Watchdog CPU:80 became unstuck
watchdog: BUG: soft lockup - CPU#136 stuck for 23s! [qemu-system-ppc:5556]
rcu_sched kthread starved for 1104 jiffies! g1772 c1771 f0x0
RCU_GP_DOING_FQS(4) ->state=0x0
Watchdog CPU:80 Hard LOCKUP
Watchdog CPU:80 became unstuck
Watchdog CPU:24 became unstuck
ipr 0001:08:00.0: FFF4: Disk device problem
ipr: -----Failing Device Information-----
ipr: World Wide Unique ID: 5000C5007E890B2B0000000000000000
ipr: Device Resource Path: 00-02
ipr: Primary Problem Description:
ipr: Secondary Problem Description:
ipr: SCSI Sense Data:
ipr: 00000000: 70000200 00000018 00000000 04000000
ipr: 00000010: 00000000 00000000 00000000 00000000
ipr: SCSI Command Descriptor Block:
ipr: 00000000: FFFFFFFF FFFFFFFF FFFFFFFF FFFFFFFF
ipr: Additional IOA Data:
ipr: 00000000: 455300CC 05B00007 00000000 84000020
ipr: 00000010: 00000000 00000000 0B7E77C0 00000000
ipr: 00000020: 00000000 0B7E70A0 C8008000 00000000
ipr: 00000030: 00000000 00000000 00000580 8F000000
ipr: 00000040: 000F8848 00000000 00000000 00000000
ipr: 00000050: 00000000 00000000 00000000 00000000
ipr: 00000060: 00000000 00000000 00000000 00000000
ipr: 00000070: 00000000 00000000 00000000 00000000
ipr: 00000080: 00000000 D4000001 80000000 FFFFFFFF
ipr: 00000090: FFFFFFFF 00000000 00268FEE 00000000
ipr: 000000A0: 00000000 00000000 01827224 00000000
ipr: 000000B0: 01B04AC0 E0030000 E0000060 04448502
ipr: 000000C0: 00000000 1B000000 01000000 00000000
ipr: 000000D0: 43440010 1B000000 01000000 00000000
ipr: 000000E0: 00000000 45480050 11001E01 1B000000
ipr: 000000F0: 04440000 D4000001 060A1E01 1B000000
ipr: 00000100: 01440000 D4000001 03021E91 1B000000
ipr: 00000110: 04448500 02040000 02001E91 00000000
ipr: 00000120: 04448500 02040000 01001EB8 00000000
ipr: 00000130: 01440000 06290300 45540004 000027D5
ipr: 00000140: 43490018 00000002 0002FFFF FFFFFFFF
ipr: 00000150: 5000C500 7E890B29 00001770 545209C0
watchdog: BUG: soft lockup - CPU#96 stuck for 24s! [ksmd:1695]

================================
WARNING: inconsistent lock state
4.13.0 #1 Tainted: G        W    L
--------------------------------
inconsistent {IN-HARDIRQ-W} -> {HARDIRQ-ON-W} usage.
scsi_eh_0/2739 [HC0[0]:SC0[0]:HE1:SE1] takes:
 (&(&ioa_cfg->hrrq[i]._lock)->rlock){?.-...}, at: [<c00000000077cd1c>]
ipr_ata_post_internal+0x16c/0x260
{IN-HARDIRQ-W} state was registered at:
  lock_acquire+0xdc/0x2f0
  _raw_spin_lock+0x4c/0x70
  ipr_ioa_reset_done+0x78/0x310
  ipr_reset_ioa_job+0x80/0xf0
  ipr_lock_and_done+0x50/0x90
  ipr_isr+0x2fc/0x650
  __handle_irq_event_percpu+0xac/0x5c0
  handle_irq_event_percpu+0x30/0x90
  handle_irq_event+0x58/0xa0
  handle_fasteoi_irq+0xc0/0x210
  generic_handle_irq+0x44/0x70
  __do_irq+0xb0/0x4e0
  call_do_irq+0x14/0x24
  do_IRQ+0x94/0x130
  hardware_interrupt_common+0x160/0x170
  __cpu_online_mask+0x0/0x100
  arch_cpu_idle+0xa0/0x170
  default_idle_call+0x44/0x84
  do_idle+0x244/0x320
  cpu_startup_entry+0x30/0x40
  rest_init+0x334/0x360
  start_kernel+0x538/0x554
  start_here_common+0x1c/0x4ac
irq event stamp: 1000
hardirqs last  enabled at (999): [<c000000000b23120>]
_raw_spin_unlock_irqrestore+0x50/0xd0
hardirqs last disabled at (1000): [<c000000000b22e64>]
_raw_spin_lock_irqsave+0x34/0xa0
softirqs last  enabled at (0): [<c0000000000f1410>]
copy_process.isra.5.part.6+0x410/0x1c20
softirqs last disabled at (0): [<          (null)>]           (null)

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&(&ioa_cfg->hrrq[i]._lock)->rlock);
  <Interrupt>
    lock(&(&ioa_cfg->hrrq[i]._lock)->rlock);

 *** DEADLOCK ***

1 lock held by scsi_eh_0/2739:
 #0:  (&(&ioa_cfg->hrrq[i]._lock)->rlock){?.-...}, at:
[<c00000000077cd1c>] ipr_ata_post_internal+0x16c/0x260

stack backtrace:
CPU: 0 PID: 2739 Comm: scsi_eh_0 Tainted: G        W    L  4.13.0 #1
Call Trace:
[c000001fef86afd0] [c000000000b0090c] dump_stack+0xe8/0x15c (unreliable)
[c000001fef86b010] [c00000000017b2b4] print_usage_bug+0x2c4/0x390
[c000001fef86b0c0] [c00000000017b4dc] mark_lock+0x15c/0x960
[c000001fef86b170] [c00000000017bd6c] mark_held_locks+0x8c/0xe0
[c000001fef86b1c0] [c00000000017be78] trace_hardirqs_on_caller+0xb8/0x240
[c000001fef86b230] [c000000000b231e0] _raw_spin_unlock_irq+0x40/0x80
[c000001fef86b260] [c00000000077c744] ipr_send_blocking_cmd+0x84/0xd0
[c000001fef86b2b0] [c00000000077c85c] ipr_device_reset+0xcc/0x210
[c000001fef86b330] [c00000000077cde0] ipr_ata_post_internal+0x230/0x260
[c000001fef86b3c0] [c0000000007a86dc] ata_exec_internal_sg+0x37c/0x640
[c000001fef86b560] [c0000000007a8a1c] ata_exec_internal+0x7c/0xe0
[c000001fef86b5d0] [c0000000007a9860] ata_dev_read_id+0x5a0/0x640
[c000001fef86b710] [c0000000007a994c] ata_dev_reread_id+0x4c/0xe0
[c000001fef86b760] [c0000000007ab6d4] ata_dev_revalidate+0xc4/0x1f0
[c000001fef86b7f0] [c0000000007bc9a0] ata_eh_recover+0x760/0x1690
[c000001fef86b920] [c0000000007be314] ata_do_eh+0x54/0x110
[c000001fef86b980] [c00000000077e8c0] ipr_eh_dev_reset+0x240/0x410
[c000001fef86ba30] [c000000000756d4c] scsi_send_eh_cmnd+0x20c/0x4a0
[c000001fef86bbb0] [c00000000075702c] scsi_eh_tur+0x4c/0xb0
[c000001fef86bbf0] [c000000000757244] scsi_eh_test_devices+0xe4/0x270
[c000001fef86bc50] [c000000000757ae0] scsi_eh_ready_devs+0x710/0x950
[c000001fef86bd20] [c0000000007593f8] scsi_error_handler+0x4b8/0x4e0
[c000001fef86bdc0] [c00000000012ca24] kthread+0x1b4/0x1c0
[c000001fef86be30] [c00000000000bcec] ret_from_kernel_thread+0x5c/0x70
BUG: sleeping function called from invalid context at
kernel/sched/completion.c:93
in_atomic(): 1, irqs_disabled(): 0, pid: 2739, name: scsi_eh_0
INFO: lockdep is turned off.
CPU: 0 PID: 2739 Comm: scsi_eh_0 Tainted: G        W    L  4.13.0 #1
Call Trace:
[c000001fef86b130] [c000000000b0090c] dump_stack+0xe8/0x15c (unreliable)
[c000001fef86b170] [c000000000139510] ___might_sleep+0x2d0/0x310
[c000001fef86b1f0] [c000000000b1c660] wait_for_common+0x50/0x230
[c000001fef86b260] [c00000000077c750] ipr_send_blocking_cmd+0x90/0xd0
[c000001fef86b2b0] [c00000000077c85c] ipr_device_reset+0xcc/0x210
[c000001fef86b330] [c00000000077cde0] ipr_ata_post_internal+0x230/0x260
[c000001fef86b3c0] [c0000000007a86dc] ata_exec_internal_sg+0x37c/0x640
[c000001fef86b560] [c0000000007a8a1c] ata_exec_internal+0x7c/0xe0
[c000001fef86b5d0] [c0000000007a9860] ata_dev_read_id+0x5a0/0x640
[c000001fef86b710] [c0000000007a994c] ata_dev_reread_id+0x4c/0xe0
[c000001fef86b760] [c0000000007ab6d4] ata_dev_revalidate+0xc4/0x1f0
[c000001fef86b7f0] [c0000000007bc9a0] ata_eh_recover+0x760/0x1690
[c000001fef86b920] [c0000000007be314] ata_do_eh+0x54/0x110
[c000001fef86b980] [c00000000077e8c0] ipr_eh_dev_reset+0x240/0x410
[c000001fef86ba30] [c000000000756d4c] scsi_send_eh_cmnd+0x20c/0x4a0
[c000001fef86bbb0] [c00000000075702c] scsi_eh_tur+0x4c/0xb0
[c000001fef86bbf0] [c000000000757244] scsi_eh_test_devices+0xe4/0x270
[c000001fef86bc50] [c000000000757ae0] scsi_eh_ready_devs+0x710/0x950
[c000001fef86bd20] [c0000000007593f8] scsi_error_handler+0x4b8/0x4e0
[c000001fef86bdc0] [c00000000012ca24] kthread+0x1b4/0x1c0
[c000001fef86be30] [c00000000000bcec] ret_from_kernel_thread+0x5c/0x70
BUG: scheduling while atomic: scsi_eh_0/2739/0x00000002
INFO: lockdep is turned off.
Modules linked in: vhost_net vhost tap iptable_mangle ipt_REJECT
nf_reject_ipv4 xt_tcpudp tun ipt_MASQUERADE nf_nat_masquerade_ipv4
xfrm_user xfrm_algo iptable_nat nf_conntrack_ipv4 nf_defrag_ipv4
nf_nat_ipv4 xt_addrtype iptable_filter ip_tables xt_conntrack x_tables
nf_nat nf_conntrack overlay bridge stp llc binfmt_misc vmx_crypto
powernv_op_panel leds_powernv led_class powernv_rng rng_core kvm_hv kvm
autofs4 xfs btrfs lzo_compress raid456 async_raid6_recov async_memcpy
async_pq async_xor async_tx xor raid6_pq libcrc32c multipath mlx4_en
raid10 crc32c_vpmsum lpfc be2net crc_t10dif crct10dif_generic
crct10dif_common mlx4_core
CPU: 0 PID: 2739 Comm: scsi_eh_0 Tainted: G        W    L  4.13.0 #1
Call Trace:
[c000001fef86af20] [c000000000b0090c] dump_stack+0xe8/0x15c (unreliable)
[c000001fef86af60] [c0000000001391f8] __schedule_bug+0x98/0xe0
[c000001fef86afd0] [c000000000b1b248] __schedule+0xca8/0x1050
[c000001fef86b0b0] [c000000000b1b63c] schedule+0x4c/0xe0
[c000001fef86b0e0] [c000000000b21b74] schedule_timeout+0x274/0x5e0
[c000001fef86b1f0] [c000000000b1c6fc] wait_for_common+0xec/0x230
[c000001fef86b260] [c00000000077c750] ipr_send_blocking_cmd+0x90/0xd0
[c000001fef86b2b0] [c00000000077c85c] ipr_device_reset+0xcc/0x210
[c000001fef86b330] [c00000000077cde0] ipr_ata_post_internal+0x230/0x260
[c000001fef86b3c0] [c0000000007a86dc] ata_exec_internal_sg+0x37c/0x640
[c000001fef86b560] [c0000000007a8a1c] ata_exec_internal+0x7c/0xe0
[c000001fef86b5d0] [c0000000007a9860] ata_dev_read_id+0x5a0/0x640
[c000001fef86b710] [c0000000007a994c] ata_dev_reread_id+0x4c/0xe0
[c000001fef86b760] [c0000000007ab6d4] ata_dev_revalidate+0xc4/0x1f0
[c000001fef86b7f0] [c0000000007bc9a0] ata_eh_recover+0x760/0x1690
[c000001fef86b920] [c0000000007be314] ata_do_eh+0x54/0x110
[c000001fef86b980] [c00000000077e8c0] ipr_eh_dev_reset+0x240/0x410
[c000001fef86ba30] [c000000000756d4c] scsi_send_eh_cmnd+0x20c/0x4a0
[c000001fef86bbb0] [c00000000075702c] scsi_eh_tur+0x4c/0xb0
[c000001fef86bbf0] [c000000000757244] scsi_eh_test_devices+0xe4/0x270
[c000001fef86bc50] [c000000000757ae0] scsi_eh_ready_devs+0x710/0x950
[c000001fef86bd20] [c0000000007593f8] scsi_error_handler+0x4b8/0x4e0
[c000001fef86bdc0] [c00000000012ca24] kthread+0x1b4/0x1c0
[c000001fef86be30] [c00000000000bcec] ret_from_kernel_thread+0x5c/0x70
ata1.00: failed to IDENTIFY (I/O error, err_mask=0x4)
ata1.00: revalidation failed (errno=-5)
ata1: hard resetting link
BUG: scheduling while atomic: scsi_eh_0/2739/0x00000000
INFO: lockdep is turned off.
Modules linked in: vhost_net vhost tap iptable_mangle ipt_REJECT
nf_reject_ipv4 xt_tcpudp tun ipt_MASQUERADE nf_nat_masquerade_ipv4
xfrm_user xfrm_algo iptable_nat nf_conntrack_ipv4 nf_defrag_ipv4
nf_nat_ipv4 xt_addrtype iptable_filter ip_tables xt_conntrack x_tables
nf_nat nf_conntrack overlay bridge stp llc binfmt_misc vmx_crypto
powernv_op_panel leds_powernv led_class powernv_rng rng_core kvm_hv kvm
autofs4 xfs btrfs lzo_compress raid456 async_raid6_recov async_memcpy
async_pq async_xor async_tx xor raid6_pq libcrc32c multipath mlx4_en
raid10 crc32c_vpmsum lpfc be2net crc_t10dif crct10dif_generic
crct10dif_common mlx4_core
CPU: 0 PID: 2739 Comm: scsi_eh_0 Tainted: G        W    L  4.13.0 #1
Call Trace:
[c000001fef86b190] [c000000000b0090c] dump_stack+0xe8/0x15c (unreliable)
[c000001fef86b1d0] [c0000000001391f8] __schedule_bug+0x98/0xe0
[c000001fef86b240] [c000000000b1b248] __schedule+0xca8/0x1050
[c000001fef86b320] [c000000000b1b63c] schedule+0x4c/0xe0
[c000001fef86b350] [c000000000b21b74] schedule_timeout+0x274/0x5e0
[c000001fef86b460] [c000000000b1c6fc] wait_for_common+0xec/0x230
[c000001fef86b4d0] [c00000000077c750] ipr_send_blocking_cmd+0x90/0xd0
[c000001fef86b520] [c00000000077c85c] ipr_device_reset+0xcc/0x210
[c000001fef86b5a0] [c000000000783698] ipr_sata_reset+0x168/0x300
[c000001fef86b660] [c0000000007b7e7c] ata_do_reset.constprop.5+0x9c/0xc0
[c000001fef86b6b0] [c0000000007bb4f0] ata_eh_reset+0x450/0xf70
[c000001fef86b7f0] [c0000000007bc59c] ata_eh_recover+0x35c/0x1690
[c000001fef86b920] [c0000000007be314] ata_do_eh+0x54/0x110
[c000001fef86b980] [c00000000077e8c0] ipr_eh_dev_reset+0x240/0x410
[c000001fef86ba30] [c000000000756d4c] scsi_send_eh_cmnd+0x20c/0x4a0
[c000001fef86bbb0] [c00000000075702c] scsi_eh_tur+0x4c/0xb0
[c000001fef86bbf0] [c000000000757244] scsi_eh_test_devices+0xe4/0x270
[c000001fef86bc50] [c000000000757ae0] scsi_eh_ready_devs+0x710/0x950
[c000001fef86bd20] [c0000000007593f8] scsi_error_handler+0x4b8/0x4e0
[c000001fef86bdc0] [c00000000012ca24] kthread+0x1b4/0x1c0
[c000001fef86be30] [c00000000000bcec] ret_from_kernel_thread+0x5c/0x70
INFO: rcu_sched self-detected stall on CPU
INFO: rcu_sched self-detected stall on CPU
INFO: rcu_sched self-detected stall on CPU
        136-...: (29493 ticks this GP) idle=c32/140000000000001/0
softirq=1602/1602 fqs=6440

        16-...: (22761 ticks this GP) idle=a5a/140000000000001/0
softirq=2650/2650 fqs=6440

 (t=41626 jiffies g=1772 c=1771 q=24199)
Sending NMI from CPU 136 to CPUs 16:
 (t=41626 jiffies g=1772 c=1771 q=24199)
        96-...: (27285 ticks this GP) idle=e5e/140000000000001/0
softirq=4303/4303 fqs=6441
         (t=41626 jiffies g=1772 c=1771 q=24199)
INFO: rcu_sched detected stalls on CPUs/tasks:
Watchdog CPU:176 Hard LOCKUP
Modules linked in: vhost_net vhost tap iptable_mangle ipt_REJECT
nf_reject_ipv4 xt_tcpudp tun ipt_MASQUERADE nf_nat_masquerade_ipv4
xfrm_user xfrm_algo iptable_nat nf_conntrack_ipv4 nf_defrag_ipv4
nf_nat_ipv4 xt_addrtype iptable_filter ip_tables xt_conntrack x_tables
nf_nat nf_conntrack overlay bridge stp llc binfmt_misc vmx_crypto
powernv_op_panel leds_powernv led_class powernv_rng rng_core kvm_hv kvm
autofs4 xfs btrfs lzo_compress raid456 async_raid6_recov async_memcpy
async_pq async_xor async_tx xor raid6_pq libcrc32c multipath mlx4_en
raid10 crc32c_vpmsum lpfc be2net crc_t10dif crct10dif_generic
crct10dif_common mlx4_core
irq event stamp: 197873857
hardirqs last  enabled at (197873856): [<c000000000b23120>]
_raw_spin_unlock_irqrestore+0x50/0xd0
hardirqs last disabled at (197873857): [<c000000000b1a6c8>]
__schedule+0x128/0x1050
softirqs last  enabled at (197859383): [<c0000000000ff518>]
__do_softirq+0x4e8/0x710
softirqs last disabled at (197859376): [<c0000000000ffc38>]
irq_exit+0x108/0x150
CPU: 176 PID: 5592 Comm: qemu-system-ppc Tainted: G        W    L  4.13.0 #1
task: c000001f55188b80 task.stack: c000001f550bc000
NIP: c0000000001a3590 LR: c00000000017eeb8 CTR: c00000000017ec80
REGS: c00000003f7bfd80 TRAP: 0900   Tainted: G        W    L   (4.13.0)
MSR: 9000000000009033 <SF,HV,EE,ME,IR,DR,RI,LE>
  CR: 48024442  XER: 00000000
CFAR: c0000000001a357c SOFTE: 0
GPR00: d00000001371acc4 c000001f550bf900 c000000001042100 c000001fdc7ed320
GPR04: 0000000000000000 0000000000000000 0000000000000002 0000000000000000
GPR08: 0000000000000010 0000000000000000 c000001f550bc000 d000000013724f30
GPR12: c00000000017ec80 c00000000fdb7000 0000000000000000 0000000000002710
GPR16: c000001fee9f1000 c000001f550bfa38 c000001fee9f10a8 c000001f55281f90
GPR20: 0000000000000008 000000000000000a c000000001087d50 0000000000000001
GPR24: 0000000000000000 d00000001371ac88 0000000000000000 0000000000000000
GPR28: 0000000000000002 0000000000000000 0000000000000000 c000001fdc7ed320
NIP [c0000000001a3590] debug_lockdep_rcu_enabled+0x40/0x50
LR [c00000000017eeb8] lock_acquire+0x238/0x2f0
Call Trace:
[c000001f550bf900] [0000000000000001] 0x1 (unreliable)
[c000001f550bf9d0] [d00000001371acc4] kvmppc_vcpu_run_hv+0x103c/0x1ea0
[kvm_hv]
[c000001f550bfb10] [d0000000136662d4] kvmppc_vcpu_run+0x2c/0x48 [kvm]
[c000001f550bfb30] [d000000013662a30]
kvm_arch_vcpu_ioctl_run+0x108/0x320 [kvm]
[c000001f550bfbd0] [d0000000136553bc] kvm_vcpu_ioctl+0x414/0x8f8 [kvm]
[c000001f550bfd40] [c0000000003b922c] do_vfs_ioctl+0xcc/0xa80
[c000001f550bfde0] [c0000000003b9c40] SyS_ioctl+0x60/0x100
[c000001f550bfe30] [c00000000000b96c] system_call+0x58/0x6c
Instruction dump:
e9290002 2fa90000 419e0028 3d22fff5 3929ca20 e9290002 2fa90000 419e0014
4bffffb0 60000000 60000000 60420000 <38600000> 4e800020 60000000 60420000
Watchdog CPU:24 Hard LOCKUP
Modules linked in: vhost_net vhost tap iptable_mangle ipt_REJECT
nf_reject_ipv4 xt_tcpudp tun ipt_MASQUERADE nf_nat_masquerade_ipv4
xfrm_user xfrm_algo iptable_nat nf_conntrack_ipv4 nf_defrag_ipv4
nf_nat_ipv4 xt_addrtype iptable_filter ip_tables xt_conntrack x_tables
nf_nat nf_conntrack overlay bridge stp llc binfmt_misc vmx_crypto
powernv_op_panel leds_powernv led_class powernv_rng rng_core kvm_hv kvm
autofs4 xfs btrfs lzo_compress raid456 async_raid6_recov async_memcpy
async_pq async_xor async_tx xor raid6_pq libcrc32c multipath mlx4_en
raid10 crc32c_vpmsum lpfc be2net crc_t10dif crct10dif_generic
crct10dif_common mlx4_core
irq event stamp: 8393517
hardirqs last  enabled at (8393517): [<c000000000017dd0>]
prep_irq_for_idle_irqsoff+0x50/0x70
hardirqs last disabled at (8393516): [<c000000000167510>] do_idle+0xb0/0x320
softirqs last  enabled at (8393506): [<c0000000000ff518>]
__do_softirq+0x4e8/0x710
softirqs last disabled at (8393485): [<c0000000000ffc38>]
irq_exit+0x108/0x150
CPU: 24 PID: 0 Comm: swapper/24 Tainted: G        W    L  4.13.0 #1
task: c000001ff245fe80 task.stack: c000001ff2504000
NIP: c000000000150630 LR: c000000000150604 CTR: c000000000924a40
REGS: c00000003fedfd80 TRAP: 0900   Tainted: G        W    L   (4.13.0)
MSR: 9000000000009033 <SF,HV,EE,ME,IR,DR,RI,LE>
  CR: 48002828  XER: 20000000
CFAR: c000000000150a68 SOFTE: 0
GPR00: c000000000150fbc c000007fffea7b10 c000000001042100 c000001fff9260a0
GPR04: c000001fe8dfce00 c000001fff921d60 0000000000000e1f 00000000000152d2
GPR08: ffffffffff48e500 0000020aee67c14e 0000020aee67c14e c000003f86b00128
GPR12: c000000000924a40 c00000000fd87800 c000001ff2507f90 0000000000000000
GPR16: c000001fff926000 0000000000000001 0000000000000001 000000000000ba7e
GPR20: 000000000000ba7e 0000000000000001 c000000000ef2520 c000001fff926000
GPR24: 0000000000000001 c000000000f8eb20 0000000000000000 0000000000000000
GPR28: 0000000000000001 c000001fff9260a0 c000001fff9260a0 c000001fe8dfce00
NIP [c000000000150630] enqueue_task_fair+0x430/0x18d0
LR [c000000000150604] enqueue_task_fair+0x404/0x18d0
Call Trace:
[c000007fffea7b10] [c000000000150fbc] enqueue_task_fair+0xdbc/0x18d0
(unreliable)
[c000007fffea7c10] [c00000000013c260] activate_task+0xa0/0x170
[c000007fffea7c90] [c00000000013ca8c] ttwu_do_activate+0x7c/0xf0
[c000007fffea7cd0] [c00000000013f330] sched_ttwu_pending+0xe0/0x140
[c000007fffea7d20] [c0000000001415f4] scheduler_ipi+0x64/0x1a0
[c000007fffea7d60] [c0000000000478cc] smp_ipi_demux_relaxed+0xac/0x110
[c000007fffea7da0] [c00000000008ed9c] icp_native_ipi_action+0x5c/0x70
[c000007fffea7dc0] [c00000000019277c] __handle_irq_event_percpu+0xac/0x5c0
[c000007fffea7e80] [c000000000192cc0] handle_irq_event_percpu+0x30/0x90
[c000007fffea7ec0] [c000000000198eec] handle_percpu_irq+0x7c/0xc0
[c000007fffea7ef0] [c000000000190e74] generic_handle_irq+0x44/0x70
[c000007fffea7f10] [c0000000000184a0] __do_irq+0xb0/0x4e0
[c000007fffea7f90] [c00000000002cc80] call_do_irq+0x14/0x24
[c000001ff2507ac0] [c000000000018964] do_IRQ+0x94/0x130
[c000001ff2507b10] [c000000000008c90] hardware_interrupt_common+0x160/0x170
--- interrupt: 501 at .L142+0x0/0x4
    LR = arch_local_irq_restore.part.5+0xa8/0xc0
[c000001ff2507e00] [c000001ff2507e70] 0xc000001ff2507e70 (unreliable)
[c000001ff2507e20] [c00000000092847c] cpuidle_enter_state+0x1ac/0x580
[c000001ff2507e80] [c000000000167314] call_cpuidle+0x44/0x90
[c000001ff2507ea0] [c000000000167710] do_idle+0x2b0/0x320
[c000001ff2507ef0] [c000000000167b30] cpu_startup_entry+0x30/0x40
[c000001ff2507f20] [c000000000048a08] start_secondary+0x338/0x350
[c000001ff2507f90] [c00000000000b26c] start_secondary_prolog+0x10/0x14
Instruction dump:
4bff6489 72290001 40820428 60000000 60000000 60000000 60000000 60000000
60000000 60000000 60000000 60420000 <60000000> e93f0050 e95e0020 80f60018
Watchdog CPU:0 Hard LOCKUP
Modules linked in: vhost_net vhost tap iptable_mangle ipt_REJECT
nf_reject_ipv4 xt_tcpudp tun ipt_MASQUERADE nf_nat_masquerade_ipv4
xfrm_user xfrm_algo iptable_nat nf_conntrack_ipv4 nf_defrag_ipv4
nf_nat_ipv4 xt_addrtype iptable_filter ip_tables xt_conntrack x_tables
nf_nat nf_conntrack overlay bridge stp llc binfmt_misc vmx_crypto
powernv_op_panel leds_powernv led_class powernv_rng rng_core kvm_hv kvm
autofs4 xfs btrfs lzo_compress raid456 async_raid6_recov async_memcpy
async_pq async_xor async_tx xor raid6_pq libcrc32c multipath mlx4_en
raid10 crc32c_vpmsum lpfc be2net crc_t10dif crct10dif_generic
crct10dif_common mlx4_core
irq event stamp: 466516031
hardirqs last  enabled at (466516030): [<c000000000b23120>]
_raw_spin_unlock_irqrestore+0x50/0xd0
hardirqs last disabled at (466516031): [<c000000000b1a6c8>]
__schedule+0x128/0x1050
softirqs last  enabled at (466516017): [<c0000000000ff518>]
__do_softirq+0x4e8/0x710
softirqs last disabled at (466516006): [<c0000000000ffc38>]
irq_exit+0x108/0x150
CPU: 0 PID: 5550 Comm: qemu-system-ppc Tainted: G        W    L  4.13.0 #1
task: c000001f57a8e880 task.stack: c000001f57b14000
NIP: c00000000030c63c LR: c00000000030c2dc CTR: c00000000030d090
REGS: c00000003ffffd80 TRAP: 0900   Tainted: G        W    L   (4.13.0)
MSR: 9000000000009033 <SF,HV,EE,ME,IR,DR,RI,LE>
  CR: 28022444  XER: 00000000
CFAR: c00000000030c5d4 SOFTE: 0
GPR00: c00000000030d190 c000001f57b17780 c000000001042100 f000000017e34740
GPR04: 000000008d1d0386 0000000000000004 0000000086031d8d f000000000000000
GPR08: c000005f8d1d0386 f000000017e34740 c000005fbd9100e8 c000001fe4ec0800
GPR12: 0000000000000000 c00000000fd80000 00007ffea11e0000 0000000000000000
GPR16: c000001fe4ec0bf8 c0000000010edc60 c000001f57b17918 00007ffea11dffff
GPR20: 000091bd5f000000 4000000000000800 4000000000002000 4000000000000000
GPR24: 0000000000000001 0008000000000040 07000000000000c0 0000005fbd910000
GPR28: 0000000000000001 c000001fd6e09508 00007ffea11d0000 00007ffea11e0000
NIP [c00000000030c63c] __get_user_pages_fast+0x42c/0xe60
LR [c00000000030c2dc] __get_user_pages_fast+0xcc/0xe60
Call Trace:
[c000001f57b17780] [0000000000000001] 0x1 (unreliable)
[c000001f57b17890] [c00000000030d190] get_user_pages_fast+0x100/0x150
[c000001f57b178e0] [d00000001371f374]
kvmppc_book3s_hv_page_fault+0x3dc/0xf40 [kvm_hv]
[c000001f57b179d0] [d00000001371acdc] kvmppc_vcpu_run_hv+0x1054/0x1ea0
[kvm_hv]
[c000001f57b17b10] [d0000000136662d4] kvmppc_vcpu_run+0x2c/0x48 [kvm]
[c000001f57b17b30] [d000000013662a30]
kvm_arch_vcpu_ioctl_run+0x108/0x320 [kvm]
[c000001f57b17bd0] [d0000000136553bc] kvm_vcpu_ioctl+0x414/0x8f8 [kvm]
[c000001f57b17d40] [c0000000003b922c] do_vfs_ioctl+0xcc/0xa80
[c000001f57b17de0] [c0000000003b9c40] SyS_ioctl+0x60/0x100
[c000001f57b17e30] [c00000000000b96c] system_call+0x58/0x6c
Instruction dump:
5128421e 54c4c03e 5128463e 50c4421e 50c4463e 790807c6 e8e70000 7d082378
790986c2 79293664 7d274a14 7d234b78 <e8e90020> 70e60001 408202dc 38c3001c
Watchdog CPU:128 Hard LOCKUP
Modules linked in: vhost_net vhost tap iptable_mangle ipt_REJECT
nf_reject_ipv4 xt_tcpudp tun ipt_MASQUERADE nf_nat_masquerade_ipv4
xfrm_user xfrm_algo iptable_nat nf_conntrack_ipv4 nf_defrag_ipv4
nf_nat_ipv4 xt_addrtype iptable_filter ip_tables xt_conntrack x_tables
nf_nat nf_conntrack overlay bridge stp llc binfmt_misc vmx_crypto
powernv_op_panel leds_powernv led_class powernv_rng rng_core kvm_hv kvm
autofs4 xfs btrfs lzo_compress raid456 async_raid6_recov async_memcpy
async_pq async_xor async_tx xor raid6_pq libcrc32c multipath mlx4_en
raid10 crc32c_vpmsum lpfc be2net crc_t10dif crct10dif_generic
crct10dif_common mlx4_core
irq event stamp: 2136863
hardirqs last  enabled at (2136862): [<c0000000001c14c4>]
ktime_get+0x154/0x180
hardirqs last disabled at (2136863): [<c000000000b1a6c8>]
__schedule+0x128/0x1050
softirqs last  enabled at (1850151): [<c0000000000ff518>]
__do_softirq+0x4e8/0x710
softirqs last disabled at (1850142): [<c0000000000ffc38>]
irq_exit+0x108/0x150
CPU: 128 PID: 5553 Comm: qemu-system-ppc Tainted: G        W    L  4.13.0 #1
task: c000001f57a97400 task.stack: c000001f57b20000
NIP: c000000000146fa0 LR: c0000000001476b0 CTR: c000000000924a40
REGS: c00000003f9ffd80 TRAP: 0900   Tainted: G        W    L   (4.13.0)
MSR: 9000000000009033 <SF,HV,EE,ME,IR,DR,RI,LE>
  CR: 48024244  XER: 20000000
CFAR: c000000000146e9c SOFTE: 0
GPR00: c000000000147908 c000001f57b23670 c000000001042100 0000000000004452
GPR04: 0000000000100000 c000005feb166c00 00000000000003b7 c000001fd7970900
GPR08: 0000000000000400 00000000fffffffe 0000000000000043 00000000ffffffff
GPR12: c000000000924a40 c00000000fda8000 0000011a3f276dae 0000000000002710
GPR16: 0000000000000000 0000000000000001 c000000000924a40 c000005fffb26000
GPR20: 0000000000000000 0000000000000001 000000000000ba7e 000000000000ba7e
GPR24: c000005fffb26000 c000000000f8eb20 0000000000000001 0000000000000000
GPR28: c000005fffb24a38 0000000000004452 c000005fffb260a0 c000005feb166c00
NIP [c000000000146fa0] __calc_delta+0x110/0x160
LR [c0000000001476b0] update_curr+0x2f0/0x3e0
Call Trace:
[c000001f57b23710] [c000000000147908] update_cfs_shares+0x148/0x150
[c000001f57b23750] [c00000000014b088] dequeue_task_fair+0xac8/0x1100
[c000001f57b23840] [c00000000013c3f8] deactivate_task+0xc8/0x1a0
[c000001f57b238c0] [c000000000b1ab6c] __schedule+0x5cc/0x1050
[c000001f57b239a0] [c000000000b1b63c] schedule+0x4c/0xe0
[c000001f57b239d0] [d00000001371aba8] kvmppc_vcpu_run_hv+0xf20/0x1ea0
[kvm_hv]
[c000001f57b23b10] [d0000000136662d4] kvmppc_vcpu_run+0x2c/0x48 [kvm]
[c000001f57b23b30] [d000000013662a30]
kvm_arch_vcpu_ioctl_run+0x108/0x320 [kvm]
[c000001f57b23bd0] [d0000000136553bc] kvm_vcpu_ioctl+0x414/0x8f8 [kvm]
[c000001f57b23d40] [c0000000003b922c] do_vfs_ioctl+0xcc/0xa80
[c000001f57b23de0] [c0000000003b9c40] SyS_ioctl+0x60/0x100
[c000001f57b23e30] [c00000000000b96c] system_call+0x58/0x6c
Instruction dump:
7d2907b4 7d074378 409effe8 4bffff30 e9450000 3920ffff 5529003c 794ab282
7faa4840 419d0020 2faa0000 419e0034 <3920ffff> 79290020 7d495392 91450008
Watchdog CPU:160 Hard LOCKUP
Modules linked in: vhost_net vhost tap iptable_mangle ipt_REJECT
nf_reject_ipv4 xt_tcpudp tun ipt_MASQUERADE nf_nat_masquerade_ipv4
xfrm_user xfrm_algo iptable_nat nf_conntrack_ipv4 nf_defrag_ipv4
nf_nat_ipv4 xt_addrtype iptable_filter ip_tables xt_conntrack x_tables
nf_nat nf_conntrack overlay bridge stp llc binfmt_misc vmx_crypto
powernv_op_panel leds_powernv led_class powernv_rng rng_core kvm_hv kvm
autofs4 xfs btrfs lzo_compress raid456 async_raid6_recov async_memcpy
async_pq async_xor async_tx xor raid6_pq libcrc32c multipath mlx4_en
raid10 crc32c_vpmsum lpfc be2net crc_t10dif crct10dif_generic
crct10dif_common mlx4_core
irq event stamp: 26487142
hardirqs last  enabled at (26487142): [<c00000000092b440>]
snooze_loop+0x40/0x1e0
hardirqs last disabled at (26487141): [<c000000000167510>]
do_idle+0xb0/0x320
softirqs last  enabled at (26487131): [<c0000000000ff518>]
__do_softirq+0x4e8/0x710
softirqs last disabled at (26487124): [<c0000000000ffc38>]
irq_exit+0x108/0x150
CPU: 160 PID: 0 Comm: swapper/160 Tainted: G        W    L  4.13.0 #1
task: c000007ff12ae800 task.stack: c000007ffc0bc000
NIP: c000000000b0ed40 LR: c000000000147b34 CTR: c000000000924a40
REGS: c00000003f87fd80 TRAP: 0900   Tainted: G        W    L   (4.13.0)
MSR: 9000000000009033 <SF,HV,EE,ME,IR,DR,RI,LE>
  CR: 48002284  XER: 00000000
CFAR: c000000000147b30 SOFTE: 0
GPR00: c000000000150678 c000007ffc0bf680 c000000001042100 c000007fe93ede10
GPR04: c000007ffee260c8 0000000000000001 c000007fe93ede00 0000000000000000
GPR08: c000007ffee260c8 c000007fe93ede10 0000000000000000 c000007fe007d0a8
GPR12: c000000000924a40 c00000000fdb2000 c000007ffc0bff90 0000000000000000
GPR16: c000007ffee26000 0000000000000001 0000000000000001 000000000000ba7e
GPR20: 000000000000ba7e 0000000000000001 c000000000ef2520 c000007ffee26000
GPR24: 0000000000000001 c000000000f8eb20 0000000000000000 0000000000000000
GPR28: 0000000000000001 c000007ffee260a0 c000007ffee260a0 c000007fe93ede00
NIP [c000000000b0ed40] rb_insert_color+0x0/0x1d0
LR [c000000000147b34] __enqueue_entity+0x94/0xc0
Call Trace:
[c000007ffc0bf680] [c000007ffee260a0] 0xc000007ffee260a0 (unreliable)
[c000007ffc0bf6a0] [c000000000150678] enqueue_task_fair+0x478/0x18d0
[c000007ffc0bf7a0] [c00000000013c260] activate_task+0xa0/0x170
[c000007ffc0bf820] [c00000000013ca8c] ttwu_do_activate+0x7c/0xf0
[c000007ffc0bf860] [c00000000013e2fc] try_to_wake_up+0x27c/0x8a0
[c000007ffc0bf8e0] [c0000000001bece0] hrtimer_wakeup+0x30/0x60
[c000007ffc0bf900] [c0000000001be674] __hrtimer_run_queues+0x154/0x790
[c000007ffc0bf990] [c0000000001bf9c0] hrtimer_interrupt+0xe0/0x330
[c000007ffc0bfa60] [c000000000026e50] __timer_interrupt+0xb0/0x520
[c000007ffc0bfac0] [c0000000000277b0] timer_interrupt+0x90/0xe0
[c000007ffc0bfaf0] [c000000000009280] decrementer_common+0x160/0x170
--- interrupt: 901 at snooze_loop+0xb4/0x1e0
    LR = snooze_loop+0x1a4/0x1e0
[c000007ffc0bfde0] [c00000000085ed66] mmc_ioctl_cdrom_play_blk+0x46/0xd0
(unreliable)
[c000007ffc0bfe20] [c00000000092842c] cpuidle_enter_state+0x15c/0x580
[c000007ffc0bfe80] [c000000000167314] call_cpuidle+0x44/0x90
[c000007ffc0bfea0] [c000000000167710] do_idle+0x2b0/0x320
[c000007ffc0bfef0] [c000000000167b34] cpu_startup_entry+0x34/0x40
[c000007ffc0bff20] [c000000000048a08] start_secondary+0x338/0x350
[c000007ffc0bff90] [c00000000000b26c] start_secondary_prolog+0x10/0x14
Instruction dump:
ebbd0010 4bffff8c fb4a0010 4bffff04 7c0802a6 fb410020 7fdaf378 f8010060
4bfffea4 60000000 60000000 60420000 <e9430000> 2faa0000 419e0140 e92a0000
Watchdog CPU:56 Hard LOCKUP
Modules linked in: vhost_net vhost tap iptable_mangle ipt_REJECT
nf_reject_ipv4 xt_tcpudp tun ipt_MASQUERADE nf_nat_masquerade_ipv4
xfrm_user xfrm_algo iptable_nat nf_conntrack_ipv4 nf_defrag_ipv4
nf_nat_ipv4 xt_addrtype iptable_filter ip_tables xt_conntrack x_tables
nf_nat nf_conntrack overlay bridge stp llc binfmt_misc vmx_crypto
powernv_op_panel leds_powernv led_class powernv_rng rng_core kvm_hv kvm
autofs4 xfs btrfs lzo_compress raid456 async_raid6_recov async_memcpy
async_pq async_xor async_tx xor raid6_pq libcrc32c multipath mlx4_en
raid10 crc32c_vpmsum lpfc be2net crc_t10dif crct10dif_generic
crct10dif_common mlx4_core
irq event stamp: 444057296
hardirqs last  enabled at (444057295): [<c000000000b23120>]
_raw_spin_unlock_irqrestore+0x50/0xd0
hardirqs last disabled at (444057296): [<c000000000b1a6c8>]
__schedule+0x128/0x1050
softirqs last  enabled at (444057282): [<c0000000000ff518>]
__do_softirq+0x4e8/0x710
softirqs last disabled at (444057265): [<c0000000000ffc38>]
irq_exit+0x108/0x150
CPU: 56 PID: 5580 Comm: qemu-system-ppc Tainted: G        W    L  4.13.0 #1
task: c000001f57ae5b80 task.stack: c000001f5508c000
NIP: d00000001371f4b4 LR: d00000001371f434 CTR: c00000000007c580
REGS: c00000003fd5fd80 TRAP: 0900   Tainted: G        W    L   (4.13.0)
MSR: 9000000000009033 <SF,HV,EE,ME,IR,DR,RI,LE>
  CR: 28024448  XER: 00000000
CFAR: d00000001371f49c SOFTE: 0
GPR00: 0008ece41f000000 c000001f5508f8e0 d000000013731d50 86031d8d5f0000c0
GPR04: 8003000000000000 c000005fbd9100e8 c000005f8d1d0386 000000008d1d0386
GPR08: 0000000000010000 0600000000000000 86031d8d5f0000c0 0000000000000000
GPR12: 0000000000000008 c00000000fd91800 00007ffea11d0000 f000000017e34740
GPR16: c000000001087d50 0000000000010000 c000001fc1708008 f000000017e34740
GPR20: 0000001fe11e1190 d00000003a2ff700 000000000215ef70 d000000018d10000
GPR24: c000007959000000 0000000000000000 00000000215ef700 0000000000000001
GPR28: 0000000000005a6d c000001fdc7e0000 c00000797a5ef700 c000001f57c8a410
NIP [d00000001371f4b4] kvmppc_book3s_hv_page_fault+0x51c/0xf40 [kvm_hv]
LR [d00000001371f434] kvmppc_book3s_hv_page_fault+0x49c/0xf40 [kvm_hv]
Call Trace:
[c000001f5508f8e0] [d00000001371f374]
kvmppc_book3s_hv_page_fault+0x3dc/0xf40 [kvm_hv] (unreliable)
[c000001f5508f9d0] [d00000001371acdc] kvmppc_vcpu_run_hv+0x1054/0x1ea0
[kvm_hv]
[c000001f5508fb10] [d0000000136662d4] kvmppc_vcpu_run+0x2c/0x48 [kvm]
[c000001f5508fb30] [d000000013662a30]
kvm_arch_vcpu_ioctl_run+0x108/0x320 [kvm]
[c000001f5508fbd0] [d0000000136553bc] kvm_vcpu_ioctl+0x414/0x8f8 [kvm]
[c000001f5508fd40] [c0000000003b922c] do_vfs_ioctl+0xcc/0xa80
[c000001f5508fde0] [c0000000003b9c40] SyS_ioctl+0x60/0x100
[c000001f5508fe30] [c00000000000b96c] system_call+0x58/0x6c
Instruction dump:
794920c4 2fa60000 7929e102 2f290000 40820868 409c0048 40960014 38c0ffff
419a000c 7d435378 78c383ce 7c0004ac <7cc028a8> 7c265000 40c20010 7c6029ad
Watchdog CPU:120 Hard LOCKUP
Modules linked in: vhost_net vhost tap iptable_mangle ipt_REJECT
nf_reject_ipv4 xt_tcpudp tun ipt_MASQUERADE nf_nat_masquerade_ipv4
xfrm_user xfrm_algo iptable_nat nf_conntrack_ipv4 nf_defrag_ipv4
nf_nat_ipv4 xt_addrtype iptable_filter ip_tables xt_conntrack x_tables
nf_nat nf_conntrack overlay bridge stp llc binfmt_misc vmx_crypto
powernv_op_panel leds_powernv led_class powernv_rng rng_core kvm_hv kvm
autofs4 xfs btrfs lzo_compress raid456 async_raid6_recov async_memcpy
async_pq async_xor async_tx xor raid6_pq libcrc32c multipath mlx4_en
raid10 crc32c_vpmsum lpfc be2net crc_t10dif crct10dif_generic
crct10dif_common mlx4_core
irq event stamp: 514558569
hardirqs last  enabled at (514558568): [<d000000013717ea8>]
kvmppc_run_core+0xdf0/0x2140 [kvm_hv]
hardirqs last disabled at (514558569): [<d000000013717ebc>]
kvmppc_run_core+0xe04/0x2140 [kvm_hv]
softirqs last  enabled at (514558449): [<c0000000000ff518>]
__do_softirq+0x4e8/0x710
softirqs last disabled at (514558442): [<c0000000000ffc38>]
irq_exit+0x108/0x150
CPU: 120 PID: 5574 Comm: qemu-system-ppc Tainted: G        W    L  4.13.0 #1
task: c000001f57ad4480 task.stack: c000001f57b74000
NIP: c00000000030c63c LR: c00000000030c2dc CTR: c00000000030d090
REGS: c00000003fa5fd80 TRAP: 0900   Tainted: G        W    L   (4.13.0)
MSR: 9000000000009033 <SF,HV,EE,ME,IR,DR,RI,LE>
  CR: 28022444  XER: 00000000
CFAR: c000000000008800 SOFTE: 0
GPR00: c00000000030d190 c000001f57b77780 c000000001042100 f000000017e34740
GPR04: 000000008d1d0386 0000000000000004 0000000086031d8d f000000000000000
GPR08: c000005f8d1d0386 f000000017e34740 c000005fbd9100e8 c000001fe4ec0800
GPR12: 0000000000000000 c00000000fda5800 00007ffea11e0000 0000000000000000
GPR16: c000001fe4ec0bf8 c0000000010edc60 c000001f57b77918 00007ffea11dffff
GPR20: 000091bd5f000000 4000000000000800 4000000000002000 4000000000000000
GPR24: 0000000000000001 0008000000000040 07000000000000c0 0000005fbd910000
GPR28: 0000000000000001 c000001fd6e09508 00007ffea11d0000 00007ffea11e0000
NIP [c00000000030c63c] __get_user_pages_fast+0x42c/0xe60
LR [c00000000030c2dc] __get_user_pages_fast+0xcc/0xe60
Call Trace:
[c000001f57b77780] [0000000000000001] 0x1 (unreliable)
[c000001f57b77890] [c00000000030d190] get_user_pages_fast+0x100/0x150
[c000001f57b778e0] [d00000001371f374]
kvmppc_book3s_hv_page_fault+0x3dc/0xf40 [kvm_hv]
[c000001f57b779d0] [d00000001371acdc] kvmppc_vcpu_run_hv+0x1054/0x1ea0
[kvm_hv]
[c000001f57b77b10] [d0000000136662d4] kvmppc_vcpu_run+0x2c/0x48 [kvm]
[c000001f57b77b30] [d000000013662a30]
kvm_arch_vcpu_ioctl_run+0x108/0x320 [kvm]
[c000001f57b77bd0] [d0000000136553bc] kvm_vcpu_ioctl+0x414/0x8f8 [kvm]
[c000001f57b77d40] [c0000000003b922c] do_vfs_ioctl+0xcc/0xa80
[c000001f57b77de0] [c0000000003b9c40] SyS_ioctl+0x60/0x100
[c000001f57b77e30] [c00000000000b96c] system_call+0x58/0x6c
Instruction dump:
5128421e 54c4c03e 5128463e 50c4421e 50c4463e 790807c6 e8e70000 7d082378
790986c2 79293664 7d274a14 7d234b78 <e8e90020> 70e60001 408202dc 38c3001c
Watchdog CPU:48 Hard LOCKUP
Modules linked in: vhost_net vhost tap iptable_mangle ipt_REJECT
nf_reject_ipv4 xt_tcpudp tun ipt_MASQUERADE nf_nat_masquerade_ipv4
xfrm_user xfrm_algo iptable_nat nf_conntrack_ipv4 nf_defrag_ipv4
nf_nat_ipv4 xt_addrtype iptable_filter ip_tables xt_conntrack x_tables
nf_nat nf_conntrack overlay bridge stp llc binfmt_misc vmx_crypto
powernv_op_panel leds_powernv led_class powernv_rng rng_core kvm_hv kvm
autofs4 xfs btrfs lzo_compress raid456 async_raid6_recov async_memcpy
async_pq async_xor async_tx xor raid6_pq libcrc32c multipath mlx4_en
raid10 crc32c_vpmsum lpfc be2net crc_t10dif crct10dif_generic
crct10dif_common mlx4_core
irq event stamp: 30086687
hardirqs last  enabled at (30086687): [<c00000000092b440>]
snooze_loop+0x40/0x1e0
hardirqs last disabled at (30086686): [<c000000000167510>]
do_idle+0xb0/0x320
softirqs last  enabled at (30086676): [<c0000000000ffaec>]
irq_enter+0x9c/0xe0
softirqs last disabled at (30086675): [<c0000000000ffad0>]
irq_enter+0x80/0xe0
CPU: 48 PID: 0 Comm: swapper/48 Tainted: G        W    L  4.13.0 #1
task: c000003ff32fcf80 task.stack: c000003ff3300000
NIP: c000000000146a88 LR: c000000000150604 CTR: c000000000924a40
REGS: c00000003fdbfd80 TRAP: 0900   Tainted: G        W    L   (4.13.0)
MSR: 9000000000009033 <SF,HV,EE,ME,IR,DR,RI,LE>
  CR: 48002282  XER: 20000000
CFAR: c000000000150600 SOFTE: 0
GPR00: c000000000150fbc c000003ff33036a0 c000000001042100 c000003fff3260a0
GPR04: c000003fe720fe00 c000003fff321d60 0000000000000e22 c000001fdcd70180
GPR08: 00000000000036da 0000000000000000 0000000000000e4b c000001fbcb82fa8
GPR12: c000000000924a40 c00000000fd8f000 c000003ff3303f90 0000000000000000
GPR16: c000003fff326000 0000000000000001 0000000000000001 000000000000ba7e
GPR20: 000000000000ba7e 0000000000000001 c000000000ef2520 c000003fff326000
GPR24: 0000000000000001 c000000000f8eb20 0000000000000000 0000000000000000
GPR28: 0000000000000001 c000003fff3260a0 c000003fff3260a0 c000003fe720fe00
NIP [c000000000146a88] account_entity_enqueue+0x8/0xf0
LR [c000000000150604] enqueue_task_fair+0x404/0x18d0
Call Trace:
[c000003ff33036a0] [c000000000150fbc] enqueue_task_fair+0xdbc/0x18d0
(unreliable)
[c000003ff33037a0] [c00000000013c260] activate_task+0xa0/0x170
[c000003ff3303820] [c00000000013ca8c] ttwu_do_activate+0x7c/0xf0
[c000003ff3303860] [c00000000013e2fc] try_to_wake_up+0x27c/0x8a0
[c000003ff33038e0] [c0000000001bece0] hrtimer_wakeup+0x30/0x60
[c000003ff3303900] [c0000000001be674] __hrtimer_run_queues+0x154/0x790
[c000003ff3303990] [c0000000001bf9c0] hrtimer_interrupt+0xe0/0x330
[c000003ff3303a60] [c000000000026e50] __timer_interrupt+0xb0/0x520
[c000003ff3303ac0] [c0000000000277b0] timer_interrupt+0x90/0xe0
[c000003ff3303af0] [c000000000009280] decrementer_common+0x160/0x170
--- interrupt: 901 at snooze_loop+0xb4/0x1e0
    LR = snooze_loop+0x1a4/0x1e0
[c000003ff3303de0] [c00000000085ed66] mmc_ioctl_cdrom_play_blk+0x46/0xd0
(unreliable)
[c000003ff3303e20] [c00000000092842c] cpuidle_enter_state+0x15c/0x580
[c000003ff3303e80] [c000000000167314] call_cpuidle+0x44/0x90
[c000003ff3303ea0] [c000000000167710] do_idle+0x2b0/0x320
[c000003ff3303ef0] [c000000000167b34] cpu_startup_entry+0x34/0x40
[c000003ff3303f20] [c000000000048a08] start_secondary+0x338/0x350
[c000003ff3303f90] [c00000000000b26c] start_secondary_prolog+0x10/0x14
Instruction dump:
7c6331d2 7c633850 7c6afe76 7d291810 7c685114 68630001 5463063e 4e800020
60000000 60420000 3c4c00f0 3842b680 <39000000> e9440000 e9230000 91030008
Watchdog CPU:80 Hard LOCKUP
Modules linked in: vhost_net vhost tap iptable_mangle ipt_REJECT
nf_reject_ipv4 xt_tcpudp tun ipt_MASQUERADE nf_nat_masquerade_ipv4
xfrm_user xfrm_algo iptable_nat nf_conntrack_ipv4 nf_defrag_ipv4
nf_nat_ipv4 xt_addrtype iptable_filter ip_tables xt_conntrack x_tables
nf_nat nf_conntrack overlay bridge stp llc binfmt_misc vmx_crypto
powernv_op_panel leds_powernv led_class powernv_rng rng_core kvm_hv kvm
autofs4 xfs btrfs lzo_compress raid456 async_raid6_recov async_memcpy
async_pq async_xor async_tx xor raid6_pq libcrc32c multipath mlx4_en
raid10 crc32c_vpmsum lpfc be2net crc_t10dif crct10dif_generic
crct10dif_common mlx4_core
irq event stamp: 9515467
hardirqs last  enabled at (9515467): [<c000000000017dd0>]
prep_irq_for_idle_irqsoff+0x50/0x70
hardirqs last disabled at (9515466): [<c000000000167510>] do_idle+0xb0/0x320
softirqs last  enabled at (9515456): [<c0000000000ff518>]
__do_softirq+0x4e8/0x710
softirqs last disabled at (9515441): [<c0000000000ffc38>]
irq_exit+0x108/0x150
CPU: 80 PID: 0 Comm: swapper/80 Tainted: G        W    L  4.13.0 #1
task: c000003ff329ff80 task.stack: c000003ff3380000
NIP: c0000000001477ec LR: c0000000001505f8 CTR: c000000000924a40
REGS: c00000003fc3fd80 TRAP: 0900   Tainted: G        W    L   (4.13.0)
MSR: 9000000000009033 <SF,HV,EE,ME,IR,DR,RI,LE>
  CR: 28002288  XER: 20000000
CFAR: c0000000001505f4 SOFTE: 0
GPR00: c000000000150fbc c000003ff33835b0 c000000001042100 c000003fe9f9ee00
GPR04: c000001febf852a8 c000003fffb21d60 0000000000b718c6 c000001fd7970900
GPR08: c000003fe87a5c00 0000000000000022 0000000000002523 c000001f57ac0028
GPR12: c000000000924a40 c00000000fd99000 c000003ff3383f90 0000000000000000
GPR16: c000003fffb26000 0000000000000001 0000000000000001 000000000000ba7e
GPR20: 000000000000ba7e 0000000000000001 c000000000ef2520 c000003fffb26000
GPR24: 0000000000000001 c000000000f8eb20 0000000000000000 0000000000000000
GPR28: 0000000000000001 c000003fffb260a0 c000003fffb260a0 c000003fe9f9ee00
NIP [c0000000001477ec] update_cfs_shares+0x2c/0x150
LR [c0000000001505f8] enqueue_task_fair+0x3f8/0x18d0
Call Trace:
[c000003ff33835f0] [c000000000150fbc] enqueue_task_fair+0xdbc/0x18d0
[c000003ff33836f0] [c00000000013c260] activate_task+0xa0/0x170
[c000003ff3383770] [c00000000013ca8c] ttwu_do_activate+0x7c/0xf0
[c000003ff33837b0] [c00000000013e2fc] try_to_wake_up+0x27c/0x8a0
[c000003ff3383830] [c000000000166eb4] swake_up_locked.part.0+0x24/0x60
[c000003ff3383860] [c000000000166f64] swake_up+0x54/0x80
[c000003ff33838a0] [d000000013653620] kvm_vcpu_kick+0xd8/0x130 [kvm]
[c000003ff33838d0] [d000000013666344] kvmppc_decrementer_func+0x2c/0x50
[kvm]
[c000003ff3383900] [d000000013660734]
kvmppc_decrementer_wakeup+0x1c/0x40 [kvm]
[c000003ff3383920] [c0000000001be674] __hrtimer_run_queues+0x154/0x790
[c000003ff33839b0] [c0000000001bf9c0] hrtimer_interrupt+0xe0/0x330
[c000003ff3383a80] [c000000000026e50] __timer_interrupt+0xb0/0x520
[c000003ff3383ae0] [c0000000000277b0] timer_interrupt+0x90/0xe0
[c000003ff3383b10] [c000000000009280] decrementer_common+0x160/0x170
--- interrupt: 901 at .L142+0x0/0x4
    LR = arch_local_irq_restore.part.5+0xa8/0xc0
[c000003ff3383e00] [c000003ff3383e70] 0xc000003ff3383e70 (unreliable)
[c000003ff3383e20] [c00000000092847c] cpuidle_enter_state+0x1ac/0x580
[c000003ff3383e80] [c000000000167314] call_cpuidle+0x44/0x90
[c000003ff3383ea0] [c000000000167710] do_idle+0x2b0/0x320
[c000003ff3383ef0] [c000000000167b30] cpu_startup_entry+0x30/0x40
[c000003ff3383f20] [c000000000048a08] start_secondary+0x338/0x350
[c000003ff3383f90] [c00000000000b26c] start_secondary_prolog+0x10/0x14
Instruction dump:
60420000 3c4c00f0 3842a940 e9030158 2fa80000 4d9e0020 fba1ffe8 fbc1fff0
f821ffc1 e9280000 e8e800f0 7929b282 <e8c70100> e9480098 ebc700e8 7d4a3050
Watchdog CPU:112 Hard LOCKUP
Modules linked in: vhost_net vhost tap iptable_mangle ipt_REJECT
nf_reject_ipv4 xt_tcpudp tun ipt_MASQUERADE nf_nat_masquerade_ipv4
xfrm_user xfrm_algo iptable_nat nf_conntrack_ipv4 nf_defrag_ipv4
nf_nat_ipv4 xt_addrtype iptable_filter ip_tables xt_conntrack x_tables
nf_nat nf_conntrack overlay bridge stp llc binfmt_misc vmx_crypto
powernv_op_panel leds_powernv led_class powernv_rng rng_core kvm_hv kvm
autofs4 xfs btrfs lzo_compress raid456 async_raid6_recov async_memcpy
async_pq async_xor async_tx xor raid6_pq libcrc32c multipath mlx4_en
raid10 crc32c_vpmsum lpfc be2net crc_t10dif crct10dif_generic
crct10dif_common mlx4_core
irq event stamp: 451872152
hardirqs last  enabled at (451872151): [<c000000000b23120>]
_raw_spin_unlock_irqrestore+0x50/0xd0
hardirqs last disabled at (451872152): [<d000000013717650>]
kvmppc_run_core+0x598/0x2140 [kvm_hv]
softirqs last  enabled at (451871992): [<c0000000000ff518>]
__do_softirq+0x4e8/0x710
softirqs last disabled at (451871985): [<c0000000000ffc38>]
irq_exit+0x108/0x150
CPU: 112 PID: 5584 Comm: qemu-system-ppc Tainted: G        W    L  4.13.0 #1
task: c000001f57af1580 task.stack: c000001f5509c000
NIP: d00000001371f4b4 LR: d00000001371f434 CTR: c00000000007c580
REGS: c00000003fabfd80 TRAP: 0900   Tainted: G        W    L   (4.13.0)
MSR: 9000000000009033 <SF,HV,EE,ME,IR,DR,RI,LE>
  CR: 28024448  XER: 00000000
CFAR: d00000001371f49c SOFTE: 0
GPR00: 0008ece41f000000 c000001f5509f8e0 d000000013731d50 8623001a1e0000c0
GPR04: 8003000000000000 c000001f08501298 c000001e1a002386 000000001a002386
GPR08: 0000000000010000 0600000000000000 8623001a1e0000c0 0000000000000000
GPR12: 0000000000000008 c00000000fda3000 00007ffa537f0000 f000000007869fc0
GPR16: c000000001087d50 0000000000010000 c000001fc1708008 f000000007869fc0
GPR20: 0000001b93801196 d000000022b71880 00000000009e6188 d000000018d10000
GPR24: c000007959000000 0000000000000000 0000000009e61880 0000000000000001
GPR28: 0000000000005a6d c000001fdc7e0000 c000007962e61880 c000001f57c92750
NIP [d00000001371f4b4] kvmppc_book3s_hv_page_fault+0x51c/0xf40 [kvm_hv]
LR [d00000001371f434] kvmppc_book3s_hv_page_fault+0x49c/0xf40 [kvm_hv]
Call Trace:
[c000001f5509f8e0] [d00000001371f374]
kvmppc_book3s_hv_page_fault+0x3dc/0xf40 [kvm_hv] (unreliable)
[c000001f5509f9d0] [d00000001371acdc] kvmppc_vcpu_run_hv+0x1054/0x1ea0
[kvm_hv]
[c000001f5509fb10] [d0000000136662d4] kvmppc_vcpu_run+0x2c/0x48 [kvm]
[c000001f5509fb30] [d000000013662a30]
kvm_arch_vcpu_ioctl_run+0x108/0x320 [kvm]
[c000001f5509fbd0] [d0000000136553bc] kvm_vcpu_ioctl+0x414/0x8f8 [kvm]
[c000001f5509fd40] [c0000000003b922c] do_vfs_ioctl+0xcc/0xa80
[c000001f5509fde0] [c0000000003b9c40] SyS_ioctl+0x60/0x100
[c000001f5509fe30] [c00000000000b96c] system_call+0x58/0x6c
Instruction dump:
794920c4 2fa60000 7929e102 2f290000 40820868 409c0048 40960014 38c0ffff
419a000c 7d435378 78c383ce 7c0004ac <7cc028a8> 7c265000 40c20010 7c6029ad
Watchdog CPU:144 Hard LOCKUP
Modules linked in: vhost_net vhost tap iptable_mangle ipt_REJECT
nf_reject_ipv4 xt_tcpudp tun ipt_MASQUERADE nf_nat_masquerade_ipv4
xfrm_user xfrm_algo iptable_nat nf_conntrack_ipv4 nf_defrag_ipv4
nf_nat_ipv4 xt_addrtype iptable_filter ip_tables xt_conntrack x_tables
nf_nat nf_conntrack overlay bridge stp llc binfmt_misc vmx_crypto
powernv_op_panel leds_powernv led_class powernv_rng rng_core kvm_hv kvm
autofs4 xfs btrfs lzo_compress raid456 async_raid6_recov async_memcpy
async_pq async_xor async_tx xor raid6_pq libcrc32c multipath mlx4_en
raid10 crc32c_vpmsum lpfc be2net crc_t10dif crct10dif_generic
crct10dif_common mlx4_core
irq event stamp: 19408319
hardirqs last  enabled at (19408319): [<c00000000092b440>]
snooze_loop+0x40/0x1e0
hardirqs last disabled at (19408318): [<c000000000167510>]
do_idle+0xb0/0x320
softirqs last  enabled at (19408308): [<c0000000000ff518>]
__do_softirq+0x4e8/0x710
softirqs last disabled at (19408297): [<c0000000000ffc38>]
irq_exit+0x108/0x150
CPU: 144 PID: 0 Comm: swapper/144 Tainted: G        W    L  4.13.0 #1
task: c000007ff1280000 task.stack: c000007ffc0fc000
NIP: c000000000150604 LR: c000000000150604 CTR: c000000000924a40
REGS: c00000003f93fd80 TRAP: 0900   Tainted: G        W    L   (4.13.0)
MSR: 9000000000009033 <SF,HV,EE,ME,IR,DR,RI,LE>
  CR: 48002488  XER: 20000000
CFAR: c000000000146b44 SOFTE: 0
GPR00: c000000000150fbc c000007ffc0ff6a0 c000000001042100 c000007ffea260a0
GPR04: c000007fe93efe00 c000007ffea21d60 0000000000000e31 0000000000003686
GPR08: 0000000000000000 0000000000000001 c000007ffea26000 c000003f88f80128
GPR12: c000000000924a40 c00000000fdad000 c000007ffc0fff90 0000000000000000
GPR16: c000007ffea26000 0000000000000001 0000000000000001 000000000000ba7e
GPR20: 000000000000ba7e 0000000000000001 c000000000ef2520 c000007ffea26000
GPR24: 0000000000000001 c000000000f8eb20 0000000000000000 0000000000000000
GPR28: 0000000000000001 c000007ffea260a0 c000007ffea260a0 c000007fe93efe00
NIP [c000000000150604] enqueue_task_fair+0x404/0x18d0
LR [c000000000150604] enqueue_task_fair+0x404/0x18d0
Call Trace:
[c000007ffc0ff6a0] [c000000000150fbc] enqueue_task_fair+0xdbc/0x18d0
(unreliable)
[c000007ffc0ff7a0] [c00000000013c260] activate_task+0xa0/0x170
[c000007ffc0ff820] [c00000000013ca8c] ttwu_do_activate+0x7c/0xf0
[c000007ffc0ff860] [c00000000013e2fc] try_to_wake_up+0x27c/0x8a0
[c000007ffc0ff8e0] [c0000000001bece0] hrtimer_wakeup+0x30/0x60
[c000007ffc0ff900] [c0000000001be674] __hrtimer_run_queues+0x154/0x790
[c000007ffc0ff990] [c0000000001bf9c0] hrtimer_interrupt+0xe0/0x330
[c000007ffc0ffa60] [c000000000026e50] __timer_interrupt+0xb0/0x520
[c000007ffc0ffac0] [c0000000000277b0] timer_interrupt+0x90/0xe0
[c000007ffc0ffaf0] [c000000000009280] decrementer_common+0x160/0x170
--- interrupt: 901 at snooze_loop+0xb4/0x1e0
    LR = snooze_loop+0x1a4/0x1e0
[c000007ffc0ffde0] [c00000000085ed66] mmc_ioctl_cdrom_play_blk+0x46/0xd0
(unreliable)
[c000007ffc0ffe20] [c00000000092842c] cpuidle_enter_state+0x15c/0x580
[c000007ffc0ffe80] [c000000000167314] call_cpuidle+0x44/0x90
[c000007ffc0ffea0] [c000000000167710] do_idle+0x2b0/0x320
[c000007ffc0ffef0] [c000000000167b34] cpu_startup_entry+0x34/0x40
[c000007ffc0fff20] [c000000000048a08] start_secondary+0x338/0x350
[c000007ffc0fff90] [c00000000000b26c] start_secondary_prolog+0x10/0x14
Instruction dump:
f95e0090 e95f0188 7d295214 f93e0088 e93f0180 2fa90000 419e0768 7fe3fb78
4bff71d5 7fe4fb78 7fc3f378 4bff6489 <72290001> 40820428 60000000 60000000
Watchdog CPU:72 Hard LOCKUP
Modules linked in: vhost_net vhost tap iptable_mangle ipt_REJECT
nf_reject_ipv4 xt_tcpudp tun ipt_MASQUERADE nf_nat_masquerade_ipv4
xfrm_user xfrm_algo iptable_nat nf_conntrack_ipv4 nf_defrag_ipv4
nf_nat_ipv4 xt_addrtype iptable_filter ip_tables xt_conntrack x_tables
nf_nat nf_conntrack overlay bridge stp llc binfmt_misc vmx_crypto
powernv_op_panel leds_powernv led_class powernv_rng rng_core kvm_hv kvm
autofs4 xfs btrfs lzo_compress raid456 async_raid6_recov async_memcpy
async_pq async_xor async_tx xor raid6_pq libcrc32c multipath mlx4_en
raid10 crc32c_vpmsum lpfc be2net crc_t10dif crct10dif_generic
crct10dif_common mlx4_core
irq event stamp: 31133390
hardirqs last  enabled at (31133389): [<c0000000001d77f4>]
tick_nohz_idle_exit+0x144/0x200
hardirqs last disabled at (31133390): [<c000000000b1a6c8>]
__schedule+0x128/0x1050
softirqs last  enabled at (31133384): [<c0000000000ffaec>]
irq_enter+0x9c/0xe0
softirqs last disabled at (31133383): [<c0000000000ffad0>]
irq_enter+0x80/0xe0
CPU: 72 PID: 0 Comm: swapper/72 Tainted: G        W    L  4.13.0 #1
task: c000003ff32b7380 task.stack: c000003ff3360000
NIP: c000000000150648 LR: c000000000150604 CTR: c000000000924a40
REGS: c00000003fc9fd80 TRAP: 0900   Tainted: G        W    L   (4.13.0)
MSR: 9000000000009033 <SF,HV,EE,ME,IR,DR,RI,LE>
  CR: 48002288  XER: 20000000
CFAR: c000000000150a68 SOFTE: 0
GPR00: c000000000150fbc c000003ff33636a0 c000000001042100 c000003fff9260a0
GPR04: c000003fe720ce00 c000003fff921d60 0000000000000e20 00000000016e3600
GPR08: 0000000002dc6c00 000001c219104704 0000000000000000 c000005fe7680128
GPR12: c000000000924a40 c00000000fd96800 c000003ff3363f90 0000000000000000
GPR16: c000003fff926000 0000000000000001 0000000000000001 000000000000ba7e
GPR20: 000000000000ba7e 0000000000000001 c000000000ef2520 c000003fff926000
GPR24: 0000000000000001 c000000000f8eb20 0000000000000000 0000000000000000
GPR28: 0000000000000001 c000003fff9260a0 c000003fff9260a0 c000003fe720ce00
NIP [c000000000150648] enqueue_task_fair+0x448/0x18d0
LR [c000000000150604] enqueue_task_fair+0x404/0x18d0
Call Trace:
[c000003ff33636a0] [c000000000150fbc] enqueue_task_fair+0xdbc/0x18d0
(unreliable)
[c000003ff33637a0] [c00000000013c260] activate_task+0xa0/0x170
[c000003ff3363820] [c00000000013ca8c] ttwu_do_activate+0x7c/0xf0
[c000003ff3363860] [c00000000013e2fc] try_to_wake_up+0x27c/0x8a0
[c000003ff33638e0] [c0000000001bece0] hrtimer_wakeup+0x30/0x60
[c000003ff3363900] [c0000000001be674] __hrtimer_run_queues+0x154/0x790
[c000003ff3363990] [c0000000001bf9c0] hrtimer_interrupt+0xe0/0x330
[c000003ff3363a60] [c000000000026e50] __timer_interrupt+0xb0/0x520
[c000003ff3363ac0] [c0000000000277b0] timer_interrupt+0x90/0xe0
[c000003ff3363af0] [c000000000009280] decrementer_common+0x160/0x170
--- interrupt: 901 at snooze_loop+0xb8/0x1e0
    LR = snooze_loop+0x1a4/0x1e0
[c000003ff3363de0] [c00000000085ed66] mmc_ioctl_cdrom_play_blk+0x46/0xd0
(unreliable)
[c000003ff3363e20] [c00000000092842c] cpuidle_enter_state+0x15c/0x580
[c000003ff3363e80] [c000000000167314] call_cpuidle+0x44/0x90
[c000003ff3363ea0] [c000000000167710] do_idle+0x2b0/0x320
[c000003ff3363ef0] [c000000000167b34] cpu_startup_entry+0x34/0x40
[c000003ff3363f20] [c000000000048a08] start_secondary+0x338/0x350
[c000003ff3363f90] [c00000000000b26c] start_secondary_prolog+0x10/0x14
Instruction dump:
60000000 60000000 60000000 60000000 60000000 60420000 60000000 e93f0050
e95e0020 80f60018 7d4a4850 54e8083c <7d49fe76> 7d083a14 7d2a5278 79080020
Watchdog CPU:64 Hard LOCKUP
Modules linked in: vhost_net vhost tap iptable_mangle ipt_REJECT
nf_reject_ipv4 xt_tcpudp tun ipt_MASQUERADE nf_nat_masquerade_ipv4
xfrm_user xfrm_algo iptable_nat nf_conntrack_ipv4 nf_defrag_ipv4
nf_nat_ipv4 xt_addrtype iptable_filter ip_tables xt_conntrack x_tables
nf_nat nf_conntrack overlay bridge stp llc binfmt_misc vmx_crypto
powernv_op_panel leds_powernv led_class powernv_rng rng_core kvm_hv kvm
autofs4 xfs btrfs lzo_compress raid456 async_raid6_recov async_memcpy
async_pq async_xor async_tx xor raid6_pq libcrc32c multipath mlx4_en
raid10 crc32c_vpmsum lpfc be2net crc_t10dif crct10dif_generic
crct10dif_common mlx4_core
irq event stamp: 513427573
hardirqs last  enabled at (513427572): [<d000000013717ea8>]
kvmppc_run_core+0xdf0/0x2140 [kvm_hv]
hardirqs last disabled at (513427573): [<d000000013717ebc>]
kvmppc_run_core+0xe04/0x2140 [kvm_hv]
softirqs last  enabled at (513427439): [<c0000000000ff518>]
__do_softirq+0x4e8/0x710
softirqs last disabled at (513427432): [<c0000000000ffc38>]
irq_exit+0x108/0x150
CPU: 64 PID: 5555 Comm: qemu-system-ppc Tainted: G        W    L  4.13.0 #1
task: c000001f57a9d100 task.stack: c000001f57b28000
NIP: c0000000001831f4 LR: c000000000b22ea4 CTR: c0000000007d25a0
REGS: c00000003fcffd80 TRAP: 0900   Tainted: G        W    L   (4.13.0)
MSR: 9000000000009033 <SF,HV,EE,ME,IR,DR,RI,LE>
  CR: 28022224  XER: 20000000
CFAR: c00000000018320c SOFTE: 0
GPR00: c000000000b22e98 c000001f57b2b0d0 c000000001042100 c000000000ef6780
GPR04: 0000000000000000 0000000000000000 0000000000000000 0000000000000001
GPR08: 0000000000000000 0000000080000088 0000000080000040 9000000000001003
GPR12: 0000000000002200 c00000000fd94000 0000000000000000 c000000000d1b8c0
GPR16: c000000000d1b8f0 c000000000d1b928 c000000000ef7380 c000000000ef5f80
GPR20: c000000000ced068 c000000000d1b890 c000000000ebee48 c000000000f35f80
GPR24: c000000001087d50 c000000001088210 c000000001088208 0000003ffe850000
GPR28: c000000000f38080 c000000000ed6b80 0000000000000000 c000000000ef6780
NIP [c0000000001831f4] do_raw_spin_lock+0x94/0x210
LR [c000000000b22ea4] _raw_spin_lock_irqsave+0x74/0xa0
Call Trace:
[c000001f57b2b0d0] [c000000000f38080] rcu_struct_flavors+0x0/0x10
(unreliable)
[c000001f57b2b100] [c000000000b22e98] _raw_spin_lock_irqsave+0x68/0xa0
[c000001f57b2b140] [c0000000001b2f38] rcu_check_callbacks+0xa58/0xd30
[c000001f57b2b280] [c0000000001bd5ec] update_process_times+0x3c/0x90
[c000001f57b2b2b0] [c0000000001d732c] tick_sched_handle.isra.5+0x2c/0xc0
[c000001f57b2b2e0] [c0000000001d7418] tick_sched_timer+0x58/0xd0
[c000001f57b2b320] [c0000000001be674] __hrtimer_run_queues+0x154/0x790
[c000001f57b2b3b0] [c0000000001bf9c0] hrtimer_interrupt+0xe0/0x330
[c000001f57b2b480] [c000000000026e50] __timer_interrupt+0xb0/0x520
[c000001f57b2b4e0] [c0000000000277b0] timer_interrupt+0x90/0xe0
[c000001f57b2b510] [c000000000009280] decrementer_common+0x160/0x170
--- interrupt: 901 at .L142+0x0/0x4
    LR = arch_local_irq_restore.part.5+0xa8/0xc0
[c000001f57b2b800] [0000000000000040] 0x40 (unreliable)
[c000001f57b2b820] [d0000000137180e0] kvmppc_run_core+0x1028/0x2140 [kvm_hv]
[c000001f57b2b9d0] [d00000001371a028] kvmppc_vcpu_run_hv+0x3a0/0x1ea0
[kvm_hv]
[c000001f57b2bb10] [d0000000136662d4] kvmppc_vcpu_run+0x2c/0x48 [kvm]
[c000001f57b2bb30] [d000000013662a30]
kvm_arch_vcpu_ioctl_run+0x108/0x320 [kvm]
[c000001f57b2bbd0] [d0000000136553bc] kvm_vcpu_ioctl+0x414/0x8f8 [kvm]
[c000001f57b2bd40] [c0000000003b922c] do_vfs_ioctl+0xcc/0xa80
[c000001f57b2bde0] [c0000000003b9c40] SyS_ioctl+0x60/0x100
[c000001f57b2be30] [c00000000000b96c] system_call+0x58/0x6c
Instruction dump:
40c2fff0 7c2004ac 2fa90000 409e0020 a12d0008 913f0008 e92d0250 f93f0010
38210030 ebe1fff8 4e800020 7c210b78 <e92d0000> 89290009 71290002 408200f0


...........
...............
...............

Watchdog CPU:64 Hard LOCKUP
Modules linked in: vhost_net vhost tap iptable_mangle ipt_REJECT
nf_reject_ipv4 xt_tcpudp tun ipt_MASQUERADE nf_nat_masquerade_ipv4
xfrm_user xfrm_algo iptable_nat nf_conntrack_ipv4 nf_defrag_ipv4
nf_nat_ipv4 xt_addrtype iptable_filter ip_tables xt_conntrack x_tables
nf_nat nf_conntrack overlay bridge stp llc binfmt_misc vmx_crypto
powernv_op_panel leds_powernv led_class powernv_rng rng_core kvm_hv kvm
autofs4 xfs btrfs lzo_compress raid456 async_raid6_recov async_memcpy
async_pq async_xor async_tx xor raid6_pq libcrc32c multipath mlx4_en
raid10 crc32c_vpmsum lpfc be2net crc_t10dif crct10dif_generic
crct10dif_common mlx4_core
irq event stamp: 605772
hardirqs last  enabled at (605771): [<c000000000b23120>]
_raw_spin_unlock_irqrestore+0x50/0xd0
hardirqs last disabled at (605772): [<c000000000b1a6c8>]
__schedule+0x128/0x1050
softirqs last  enabled at (598290): [<c0000000000ff518>]
__do_softirq+0x4e8/0x710
softirqs last disabled at (598269): [<c0000000000ffc38>]
irq_exit+0x108/0x150
CPU: 64 PID: 9 Comm: rcu_sched Tainted: G        W    L  4.13.0 #1
task: c000001ff2411700 task.stack: c000001ff2498000
NIP: c000000000154d58 LR: c000000000140c4c CTR: c000000000924a40
REGS: c00000003fcffd80 TRAP: 0900   Tainted: G        W    L   (4.13.0)
MSR: 9000000000009033 <SF,HV,EE,ME,IR,DR,RI,LE>
  CR: 28002242  XER: 20000000
CFAR: c000000000154b50 SOFTE: 0
GPR00: c000000000140c4c c000001ff249b5f0 c000000001042100 c000003fff726000
GPR04: c000001ff2411700 c000003fff721d60 0000000291eb45a6 c000000001116680
GPR08: c000001fff311080 c000001fff311080 c000001fff311140 00000000000006ec
GPR12: 0000000000000000 c00000000fd94000 00000000000006ec 0000000000000000
GPR16: 0000000000000000 0000000000000003 0000000000000004 0000000000000000
GPR20: c000000000d1b1a8 c000003fff711140 0000000000000001 000002def32ebc8f
GPR24: c000003fff711098 0000000000000000 c000001ff2411700 c000003fff726018
GPR28: c000000001083bf8 0000000000000200 0000000000000000 c000003fff726000
NIP [c000000000154d58] task_tick_fair+0x608/0x6d0
LR [c000000000140c4c] scheduler_tick+0xac/0x1b0
Call Trace:
[c000001ff249b5f0] [c000000000140c4c] scheduler_tick+0xac/0x1b0 (unreliable)
[c000001ff249b650] [c0000000001bd60c] update_process_times+0x5c/0x90
[c000001ff249b680] [c0000000001d732c] tick_sched_handle.isra.5+0x2c/0xc0
[c000001ff249b6b0] [c0000000001d7418] tick_sched_timer+0x58/0xd0
[c000001ff249b6f0] [c0000000001be674] __hrtimer_run_queues+0x154/0x790
[c000001ff249b780] [c0000000001bf9c0] hrtimer_interrupt+0xe0/0x330
[c000001ff249b850] [c000000000026e50] __timer_interrupt+0xb0/0x520
[c000001ff249b8b0] [c0000000000277b0] timer_interrupt+0x90/0xe0
[c000001ff249b8e0] [c000000000009280] decrementer_common+0x160/0x170
--- interrupt: 901 at .L142+0x0/0x4
    LR = arch_local_irq_restore.part.5+0xa8/0xc0
[c000001ff249bbd0] [0000000000000001] 0x1 (unreliable)
[c000001ff249bbf0] [c000000000b2312c] _raw_spin_unlock_irqrestore+0x5c/0xd0
[c000001ff249bc20] [c0000000001afb8c] force_qs_rnp+0x21c/0x240
[c000001ff249bca0] [c0000000001b0488] rcu_gp_kthread+0x8d8/0x1bc0
[c000001ff249bdc0] [c00000000012ca24] kthread+0x1b4/0x1c0
[c000001ff249be30] [c00000000000bcec] ret_from_kernel_thread+0x5c/0x70
Instruction dump:
7d0a4214 7d485010 7d4a5110 7d085078 4bfffce4 60420000 382100e0 7ea4ab78
7e83a378 81810008 ea81ffa0 eaa1ffa8 <ebc1fff0> 7d908120 4bfff8c8 60000000
Watchdog CPU:80 became unstuck
Watchdog CPU:64 became unstuck
Watchdog CPU:72 became unstuck
Watchdog CPU:128 became unstuck
Watchdog CPU:104 became unstuck
Watchdog CPU:112 became unstuck
Watchdog CPU:48 became unstuck
Watchdog CPU:160 became unstuck
Watchdog CPU:8 became unstuck
Watchdog CPU:56 became unstuck
Watchdog CPU:176 became unstuck
Watchdog CPU:120 became unstuck



Server wasn't network accessible at this point.


Running 'ip addr' on FSP console didn't return.




x86_64 as VM host:

ozlabs@ka5:~$ virsh list
 Id    Name                           State
----------------------------------------------------
 2     mysql_ci_test_x86_64           running

ozlabs@ka5:~$ uname -a
Linux ka5 4.13.0-svaidy+ #6 SMP Thu Sep 7 08:41:39 IST 2017 x86_64
x86_64 x86_64 GNU/Linux




danielgb@p88:~$ sshfs ozlabs@ka5-mysql:/home/ozlabs/mariadb-server   ka5_vm/
The authenticity of host 'ka5-mysql (10.61.210.122)' can't be established.
ECDSA key fingerprint is SHA256:Lr6FwhdSN5CWK++GdTTcH35A5NvFhAmfS3t2SCH/Oi4.
Are you sure you want to continue connecting (yes/no)? yes
ozlabs@ka5-mysql's password:
danielgb@p88:~$ ls ka5_vm
BUILD        cmake           configure.cmake     CREDITS  Docs
    include             KNOWN_BUGS.txt  libservices  mysys      plugin
  scripts    sql-common  support-files  VERSION  wsrep
BUILD-CMAKE  CMakeLists.txt  COPYING             dbug
EXCEPTIONS-CLIENT  INSTALL-SOURCE      libmariadb      man
mysys_ssl  randgen    sql        storage     tests          vio      zlib
client       config.h.cmake  COPYING.thirdparty  debian   extra
    INSTALL-WIN-SOURCE  libmysqld       mysql-test   pcre
README.md  sql-bench  strings     unittest       win

danielgb@p88:~$ mkdir build-mariadb-10.2-outoftree
danielgb@p88:~$ cd build-mariadb-10.2-outoftree
danielgb@p88:~/build-mariadb-10.2-outoftree$ cmake
-DCMAKE_C_COMPILER="gcc" -DCMAKE_CXX_COMPILER="g++"  ../ka5_vm/

...
-- Looking for event.h - not found
-- Configuring done
-- Generating done
-- Build files have been written to:
/home/danielgb/build-mariadb-10.2-outoftree
danielgb@p88:~/build-mariadb-10.2-outoftree$ make -j 400
.....
[  5%] Linking C static library libvio.a
[  5%] Built target vio
/home/danielgb/ka5_vm/libmariadb/libmariadb/mariadb_dyncol.c:4050:15:
warning: argument 1 null where non-null expected [-Wnonnull]
         *dbl= strtod(str, &end);
               ^~~~~~~~~~~~~~~~~
In file included from
/home/danielgb/ka5_vm/libmariadb/include/ma_global.h:168:0,
                 from
/home/danielgb/ka5_vm/libmariadb/libmariadb/mariadb_dyncol.c:64:
/usr/include/stdlib.h:164:15: note: in a call to function ‘strtod’
declared here
 extern double strtod (const char *__restrict __nptr,
               ^~~~~~
[  5%] Linking CXX static library libhsclient.a
[  5%] Built target hsclient
Scanning dependencies of target gen_lex_token
[  5%] Built target GenServerSource

ozlabs@ka5:~$ virsh suspend  mysql_ci_test_x86_64
Domain mysql_ci_test_x86_64 suspended


danielgb@p88:~$ killall -9 cc1 g++
cc1(102299): Operation not permitted
cc1(102335): Operation not permitted
cc1(102459): Operation not permitted
cc1(102460): Operation not permitted
cc1(102486): Operation not permitted
cc1(102488): Operation not permitted
g++: no process found

danielgb@p88:~$ killall -9 cmake


x86_64 host, ka5, show the hung_task_timeout_sec warning however remains
operational.
