Date: Mon, 19 Apr 1999 13:52:35 -0500 (CDT)
From: Troy Benjegerdes <hozer@drgw.net>
To: Martin Costabel <costabel@wanadoo.fr>
cc: Franz Sirl <Franz.Sirl@munich.netsurf.de>, Tom Rini <tmrini@ntplx.net>,
        linuxppc-dev@lists.linuxppc.org,
        Hans-Bernhard Broeker <broeker@physik.rwth-aachen.de>
Subject: Re: [Patch] linuxppc gnuplot segfaults in save
In-Reply-To: <3715C58D.1C438D65@wanadoo.fr>
Message-ID: <Pine.LNX.4.04.9904191342501.9610-100000@narn.local.drgw.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


There's a problem with the test code posted earlier.. It segfaults on x86
also..

int main(int argc, char** argv)
{
        char* file_name;                    <-----------
        strcpy(file_name, argv[1]);         <----------
        test_fprintf(fopen(file_name, "w"));
        exit(0);
}        

file_name is initially set to 0x0 on the RedHat 5.1 Intel box, thus
causeing a segfault. On PPC, the pointer is initially pointing somewhere
on the stack (in my case to 0x7ffffcf0)

with the following code, it doesn't segfault on the x86 box, and has the
same crash in _IO_vfprintf on my PPC boxes (glibc-2.1 and glibc-1.99)

int main(int argc, char** argv)
{
        test_fprintf(fopen(argv[1], "w"));
        exit(0);
}   

--------------------------------------------------------------------------
| Troy Benjegerdes    |       troy@microux.com     |    hozer@drgw.net   |
|    Unix is user friendly... You just have to be friendly to it first.  |
| This message composed with 100% free software.    http://www.gnu.org   |
--------------------------------------------------------------------------


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
