Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-Id: <200006210707.JAA01454@denx.local.net>
To: Murray Jensen <Murray.Jensen@cmst.csiro.au>
cc: Mike Coy <coym@embeddedplanet.com>,
        Lucinda Schafer <lucsch@adaptivemicro.com>,
        linuxppc-embedded@lists.linuxppc.org
Subject: Re: PCMCIA ATA flash support? 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-Type: multipart/mixed ;
	boundary="==_Exmh_-21000115340"
Date: Wed, 21 Jun 2000 09:07:43 +0200
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is a multipart MIME message.

--==_Exmh_-21000115340
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 21 Jun 2000 12:09:26 +1000."
             <5824.961553366@msa.cmst.csiro.au>
Content-Transfer-Encoding: 8bit

In message <5824.961553366@msa.cmst.csiro.au> Murray Jensen wrote:
>
> They won't be - the backtrace prints the return (or link in ppc speak)
> address i.e. the next instruction to be executed after a return from the
> current function (or stack frame). Just sort your System.map file on the

The System.map file  _is_ already sorted.

> first column (hex address) and then look for the largest value in the
> first column that is still less than the next address in the backtrace.
> This gives you some idea of which function that address is within, and
> how far in that function it is. A bit tedious but ok for a start.

No need to do this by hand. See the attached script - just  give  the
path  of  the  System.map  file  to  use  as  argument,  and feed the
backtrace to stdin.

> What would be better is to get kgdb working, then gdb will work all this

I agree.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Knowledge, sir, should be free to all!
	-- Harry Mudd, "I, Mudd", stardate 4513.3


--==_Exmh_-21000115340
Content-Type: text/plain ; name="backtrace"
Content-Description: backtrace
Content-Disposition: attachment; filename="backtrace"

#!/usr/bin/perl -w

my $mapfile = shift || '/LinuxPPC/usr/src/linux/System.map';

print STDERR "Reading symbols from $mapfile\n";

#
# Read symbol table
#
open (MAP, $mapfile) or die "Can't open $mapfile: $!\n";

my $cnt = 0;

while (<MAP>) {
	chomp;
	my ($a,$t,$n) = split;
	$a = eval ('0x' . $a);
	if ($t =~ /^t$/i) {
		$addr[$cnt] = $a;
		$name[$cnt] = $n;
		++$cnt;
	}
}
close MAP;

my ($i, $n, $last);

#for ($i=0; $i<$cnt; ++$i) {
#	printf "0x%08x  %s\n", $addr[$i], $name[$i];
#}

#
# Now get backtrace info from stdin
#

while (<>) {
	chomp;
	my @a = split;
	my $aa;

	for ($i=0; $i<=$#a; ++$i) {
		$aa = eval ('0x' . $a[$i]);

		$last = -1;
		for ($n=0; $n<$cnt; ++$n) {
			if ($addr[$n] > $aa) {
				last;
			}
			$last = $n;
		}

		if ($last >= 0) {
			my $offset = $aa - $addr[$last];

			printf "0x%08x -- 0x%08x + 0x%04x   %s\n",
				$aa, $addr[$last], $offset, $name[$last];
		} else {
			printf "0x%08x -- unknown address\n", $aa;
		}
	}
}

--==_Exmh_-21000115340--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
