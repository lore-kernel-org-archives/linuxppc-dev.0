From: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
To: Pierre Sarrazin <sarrazip@machinasapiens.com>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: R_PPC_REL24 relocation out of range, with trivial program
Date: Mon, 3 Apr 2000 23:34:02 +0200
Content-Type: text/plain
References: <38E90159.DB89C967@machinasapiens.com>
In-Reply-To: <38E90159.DB89C967@machinasapiens.com>
MIME-Version: 1.0
Message-Id: <00040323364000.01288@enzo.bigblue.local>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Am Mon, 03 Apr 2000 schrieb Pierre Sarrazin:
>Last month I posted the following message:
>
>From: Pierre Sarrazin
>Date: Thu, 02 Mar 2000 18:25:46 -0500
>> This is another message about the "R_PPC_REL24 relocation out of range"
>> problem. I have a trivial program and library system that illustrates it.
>> I have read some of the previous messages on this topic but the solutions
>> proposed did not make a difference.
>>
>> The problem happens when the dlopened library exports a C++
>> function returning 'string', but not when it exports a function
>> returning 'const char *'.
>>
>> Here is the program:
>	[...]
>
>
>The full message is at:
>http://lists.linuxppc.org/listarcs/linuxppc-dev/200003/msg00025.html
>
>
>I would like to know if there is a chance that this problem will
>be fixed soon. I have had to suspend my LinuxPPC work for the
>last month. My company's support for the LinuxPPC platform is
>delayed by this issue.
>
>Is there a way to ask gcc to generate only long branch instructions
>so as to avoid this whole problem? Thanks.

This seems to be fixed in the current toolchain:

[fsirl@entropy:~/bugs/reloc]$ make
g++ -g -Wall -fPIC -DSTRING_EXAMPLE -c prog.cpp
g++ -g -Wall -fPIC -DSTRING_EXAMPLE -o prog prog.o -ldl
g++ -g -Wall -fPIC -DSTRING_EXAMPLE -c f.cpp
g++ -shared -o libf.so f.o
[fsirl@entropy:~/bugs/reloc]$ ./prog
f()
s = [pizza]

Either upgrade your distribution or go to
<ftp://devel.linuxppc.org/users/fsirl>.

Franz.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
