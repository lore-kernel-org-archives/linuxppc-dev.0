Date: Sat, 25 Dec 1999 01:28:11 +0100
To: linuxppc-dev@lists.linuxppc.org, linuxppc-user@lists.linuxppc.org
From: BenH <bh40@calva.net>
Subject: OF simple boot chooser
Message-Id: <19991225012811.003886@smtp.calvacom.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


A chrismas present for happy hackers ;)

I did a few hacking with OF tonight. On newworld machine, you can use the
following script as a bootfile (and set OF to boot from this script
instead of the toolbox ROM image):

<CHRP-BOOT>
<COMPATIBLE>
iMac,1 PowerMac1,1 PowerBook1,1 PowerMac2,1 PowerMac3,1 PowerBook2,1
</COMPATIBLE>
<DESCRIPTION>
Linux/PPC Yaboot bootloader
</DESCRIPTION>
<BOOT-SCRIPT>
" get-key-map" " keyboard" open-dev $call-method
dup 20 dump
5 + c@ 08 = if
" Booting MacOS ..." cr " boot hd:,\\:tbxi" eval
else
" Booting Yaboot ..." cr " hd:,\\yaboot" eval
then
</BOOT-SCRIPT>
</CHRP-BOOT>


Setting OF boot to this script (with OF "setenv" command) instead of
yaboot or the toolbox ROM image will cause the following behaviour:

if the spacebar is _not_ pressed, yaboot will be loaded. If the spacebar
is pressed, MacOS will be loaded. Note that the path " hd:, \\:tbxi" and
" hd:,yaboot"  may need to be changed depending on your configuration.
Those ones respectively means "the fist MacOS ROM Image file you find on
the internal ATA HD" and "the first file named yaboot you find at the
root of any HFS partition of the internal ATA HD".

The syntax is:

" device:partition,file" (do not forget the space after the first
double-quote)

"device"     is the OF device. "hd:" usually means the internal ATA hard-disk

"partition"  is the partition number. You can omit it (but you need to
leave the ",").
             In  this case, OF will try to look for the file on all
partitions of the
             device (HFS partitions) until it finds it

"file"       is the path to the file to load. "\\" means the active MacOS
system folder
             and ":xxxx" means a file whose MacOS type is "xxxx". so
"\\:tbxi" means a
             file of type "tbxi" in the active MacOS system folder


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
