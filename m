Message-Id: <5.1.0.14.2.20030410080317.026eecd8@falcon.si.com>
Date: Thu, 10 Apr 2003 08:14:07 -0400
To: linuxppc-embedded@lists.linuxppc.org
From: Jerry Van Baren <gerald.vanbaren@smiths-aerospace.com>
Subject: Re: AW: parse error before `{', stray '\' in program
In-Reply-To: <0002BD8C.C22236@siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Suggestion #1, use a better editor under windows such as UltraEdit (yeah, I
know, ain't gonna happen).

Suggestion #2, in your build procedure, run "dos2unix" program on your
files before building them.  Note that various names have been used for
this utility such as undos and dos2unix.  If you want to be a Real Unix
Programmer, awk, sed, or tr can do the job.

The problem is the compiler isn't seeing the '\' as the last character in
the line because of the pesky '\r' -- the C rules say '\' must be the LAST
character on the line and DOS line termination violates this if the
compiler is not using DOS line termination conventions.

gvb


At 01:15 PM 4/10/2003 -0400, alex.graf@siemens.com wrote:

>I would use Unix file formats if i can!
>The problem is: We have developers on Windows. They are working with the
>same library as we are. Visual Studio produce this f... <cr><lf> or ^M or
>\r\n. And we are generatin code from Rose. This cause the same problems.
>Visual Studio has no problems with \n, but if someone save the file with
>Visual Studio, the problem occurs. (The same is with Rose)
>gcc 3.2 on host has no problem with this <cr><lf>. Is there allready a cross
>compiler (ppc_8xx-gcc) with verision 3.2? Or how difficult is it to build a
>new compiler?
>
>Cheers
>
>Alex Graf
>
>
>...
>This is usually caused by illegal file formats.
>
> > The troubles are coming from the dos <cr><lf> at line end. With gcc 3.2
> > (from host) I don't have this problems.
>
>Use Unix file formats (plain '\n' line termination).
>Wolfgang Denk
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
