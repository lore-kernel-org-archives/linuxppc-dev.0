Message-ID: <002301c0b279$16591e20$8021690a@huawei.com>
From: "machael" <dony.he@huawei.com.cn>
To: "Wolfgang Denk" <wd@denx.de>, "Dan Malek" <dan@mvista.com>,
	"Murray Jensen" <Murray.Jensen@cmst.csiro.au>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Subject: Strange problem after shell appears...
Date: Thu, 22 Mar 2001 10:37:49 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,all:

Now I can boot linux on my 8260-based custom board. But I have a strange
problem:

#############################
.....................
VFS: Mounted root (nfs filesystem).
Freeing unused kernel memory: 48k init
Standalone shell (version 1.0)
> hel^@
###############################

After shell appears, I cannot run any built-in commands such as  "cp" etc...
As you can see above, when  I type _EXACTLY_ 3 characters(for example,
"hel"),
then it appends "^@" automatically at once(So you see "hel^@" above). Then
it stops there. It has no any response  when I try to type any more
characters. But I can ping it from my host computer.
This means the target board is not crashed...

If I first type "ls", then press "Enter" key, then there are correct output
for "ls". But after that it has the same result as above: That is to say,
I have type 3 characters("ls" + "Enter" ), and "^@" also appended
automatically. I cannot type any character at this time.

I don't know what may cause this happen? I have look for the ASCII table and
find that "^@" mean "NULL".
Maybe this is a uart driver problem? What do you have to modify
arch/ppc/8260_io/uart.c when you port linux on your 8260-based custome
board?


Of course I am sure the root NFS is OK. I have tried cross-compile sash
statically or dynamically, but both have the same result as above:

###########################################
    powerpc-linux-gcc -O2 -c -o sash.o sash.c
    powerpc-linux-gcc -O2 -c -o cmds.o cmds.c
    .....................
then:
    powerpc-linux-ld -O2 -static -s -o sash sash.o cmds.o ......
or
   powerpc-linux-ld  -O2 -Wl,--rpath,/lib -o sash sash.o cmds.o ...
################################################

Any ideas? I am really much confused :-(((
Thank you very much.

machael


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
