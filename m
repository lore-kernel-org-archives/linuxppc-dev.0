MIME-Version: 1.0
Subject: RE: crashme produces hang of linux
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Mon, 23 Apr 2001 13:23:48 -0000
Message-ID: <EADB10BAC266A14A85ECBF8686A73E314590F2@kolkrabbi.flaga.is>
From: =?iso-8859-1?B?S+FyaSBEYXbt8HNzb24=?= <kd@flaga.is>
To: <nunninger@web.de>,
	"linuxppc-embedded List" <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

Once I was exsperimenting with crashme and it was very easy to get it to
crash the kernel, it was always on floating point instructions. It was
before there was
any floating point emulation in the kernel (in the 2.2.x days and you
are running
2.2.14). I have not tried crashme since then but you might want to look
into this
floating point instructions issue. crashme just tries to run randomly
generated
code so floating point instrauctions are just as likely as any other
instructions,
even though crashme itself is compiled with -msoft-float and -mcpu=860.

Then again I might be totally wrong.....

Hope this helps,

K.D.

> -----Original Message-----
> From: Stefan Nunninger [mailto:stefan.nunninger@enst.fr]
> Sent: 23. apríl 2001 12:30
> To: linuxppc-embedded List
> Subject: crashme produces hang of linux
>
>
>
> Hello,
>
> I got a Montavista kernel 2.2.14 running on a custom
> board with a MPC860 powerpc. The root file system is
> mounted over nfs from a PC running an nfs server.
>
> To check the stability of the board I was running several
> tests. First I used all kind of applications I could
> imagine and tried whether they are working fine. I found
> no problems using anyting like that. This includes
> basic programs like ls, cd, vi, tar, gzip, top, ftp, ftpd
> telnet, telnetd, httpd etc.
> Also the board runs for several days when used as websever
> even though not under heavy load. So I felt quite confident
> everything works fine.
>
> Now I tried to verify the board's stability using crashme.
> Crashme is a program that tests the stability of a operating system.
> It generates random code and executes it. Obviously this will
> generate all kind of errors as segmentation faults, illegal
> instructions etc. That is fine and is a wanted property.
> However it is expected that crashme may not crash or hang
> the operating system.
> Unfortunately I found that my system hangs shortly after starting
> crashme. The kernel seems to work still fine as it reacts to ping
> requests. However it is not possible to connect to the system
> using telnet or ftp. Also the console, which is connected via the
> serial port (minicom), does not react. The only solution I found
> was restarting the system.
>
> Thus this seems to indicates some stability problems on my embedded
> device.
> It might be that this is nothing serious as such a situation should
> not occur during normal operation. Still it would be better if the
> kernel would stay useable even in an extrem situation as when using
> crashme.
>
> Shurely it would be interesting to know what kind of instruction
> produces the hang. There is a possibility to let the program write
> a logfile in which the code that is execute is stored. After a crash
> the last line in the logfile should give the instruction producing
> the crash. However to use this the sync mechanism of linux has to
> be switched off. Because syncing would prevent the data be written
> immediately to disk. The sync buffer however will be lost after
> the crash. For the case of the embedded device there is a further
> problem. When the kernel crashes it crashes probably also the
> network connection which is necessary for the nfs connection.
> Thus quite likely the last instruction will not be transfered by
> nfs. Thus I do not know which instruction produces the hang.
>
> After all I would be interested in hearing what you think about all
> that.
> Do you think crashme is a useful test at all. Should I simple ignore
> the result and be happy that so far no other problems occured.
> Or is it probable that the board will get unstable in some rare
> cases.
> What might be the reason for the hang. Is there anything obvious I
> should
> check. As I've read several times that memory is a difficult task
> with
> linux I veryfied the UMPA values I'm using. As I have no logic
> analyzer
> at hand this was only a check for plausability of the values.
>
> And finally has anybody done similar tests. Which further tests
> should I do for stability?
> Also I'd like to figure out the performance of the board.
> I'm especially interested in benchmarks which give an idea of basic
> values like raw processing speed, file system performance, memory
> and
> network performance. And finally I'd like to compare my device to
> other
> embedded devices and to known PC systems.
>
> Any ideas are welcome - many thanks
> 	Stefan
>
> --
> Stefan Nunninger
> Ecole nationale superieure des telecommunications
> 46, Rue Barrault
> 75634 Paris Cedex 13
> Tel: 01 45 81 7507 (bureau)
>      01 45 81 7600 (laboratoire)
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
