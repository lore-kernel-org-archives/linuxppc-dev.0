From: jlhagen@collins.rockwell.com
Subject: Re: prepboot, head.S questions.
To: linuxppc-dev@lists.linuxppc.org
Date: Thu, 7 Dec 2000 15:20:09 -0600
Message-ID: <OF42F0444D.CA210154-ON862569AE.00752304@collins.rockwell.com>
MIME-Version: 1.0
Content-type: multipart/mixed;
	Boundary="0__=862569AE007523048f9e8a93df938690918c862569AE00752304"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--0__=862569AE007523048f9e8a93df938690918c862569AE00752304
Content-type: text/plain; charset=us-ascii


---------------------- Forwarded by John L
Hagen/CedarRapids/Collins/Rockwell on 12/07/2000 03:15 PM
---------------------------
(Embedded image moved to file: pic23967.pcx)

John L Hagen
12/07/2000 03:19 PM

To:   Gabriel Paubert <paubert@iram.es>
cc:

Subject:  Re: prepboot, head.S questions.  (Document link: John L Hagen)





Gabriel Paubert <paubert@iram.es> on 12/07/2000 05:04:41 AM

To:   jlhagen@collins.rockwell.com
cc:   linuxppc-dev@lists.linuxppc.org

Subject:  Re: prepboot, head.S questions.




On Wed, 6 Dec 2000 jlhagen@collins.rockwell.com wrote:

>
> Hello all,
>
> does a FAQ exist for this list?? I have an obvious newbie question. Could
> someone quickly explain the structure of arch/ppc, I'm really looking at
> the different head.S files. It looks like the arch/ppc/kernel/head.S
> contains low-level code for all architectures and the arch/ppc/[boot
> coffboot etc..] are the different bootloaders. Is this correct??
>
> Also from reading the list archives it sounded like the prepboot code
from
> Gabriel, or code based on his work,  was to eventually make it into the
ppc
> source tree. I believe this discussion was quite a while ago, 1999
> sometime. Is this still the plan? Or maybe items from prepboot are being
> merged into arch/ppc/boot ( If I understand the structure correctly )?

I hope to build a better version of my prepboot code early next year. This
has nothing to do with arch/ppc/kernel/head.S which runs after and
is the true early kernel boot but is too much of a mess.

Actually I would like to see a lot of the functionality of kernel/head.S
moved to the bootloader. I have a version of "prepboot" which is able to
read OF device tree and put it in some place for late use by the kernel,
instantiating RTAS would also be easy if I could test it but my OF machine
does not have RTAS.

This is much cleaner that the whole mess of running code at an address it
has not been foreseen to run. prepboot is compliled with -mrelocatable and
will run anywhere it is loaded even by funky firmware like PPCBUG (the
load address depends on whether I boot from disk or network) and move
itself to make room to uncompress the kernel if necessary. There is no
built-in fixed address in prepboot, absolutely none except for the
exception handlers (determined by hardware). It could be used on machines
which do not have RAM at 0 with very minor modifications affecting only
the installation of the exception handlers.


     Gabriel.



Yes, kernel/head.S is messy. I'm trying to learn this and the first time
you read through it it's amusing. Let's here it for funky firmware :)
Anyway, a better version, hmm, this one is pretty sharp as is. For our mvme
boards your diffs against 2.2.12 work for me using both nfs and initrd
(which is pretty cool) file systems. I can get the 2.4.0-test5 diff to work
for nfs but not initrd. See below for a side note on my initrd problems
with the test5 diff. It's the initrd stuff that I'm really interested in
getting working.

Ok, I understand the kernel/head.S stuff now. Bear with me as I'm just
beginning my work so I'll ask a lot of stupid questions. Why do you touch
the files in ppc/boot in your prepboot patch?? The changes look pretty
benign until the vreset.c (vga). Do I miss understand the ppc/boot purpose?
Isn't this a generic ppc boot 'loader'? This isn't really needed or built
when I'm using the PREPBOOT right?? I image since these are diffs from your
kernel sources there is other stuff included that might not necessarily be
needed specifically for the prepboot functionality. I'm trying to muscle
only the prepboot stuff into the test1 kernel source ( I have the naive
notion that I would learn the particulars by doing this ). So I'm trying to
eliminate as many things as possible at this time.

     John,



SIDE NOTE: here is some console information on the initrd problems I'm
having with 2.4.0-test5 if you would like them. I actually have all the
messages I just thought these might be usefull.

Now booting...
Kernel at 0x00000000, size=0x172204
Initrd at 0x01e3eb4c, size=0x12fb7a
Boot info 0x00173000, size=0x70
Residual data at 0x00174000
PReP architecture
mem_pieces_remove: [41e3e000,41f6db7a) not in any region
Total memory = 32MB; using 128kB for hash table (at c0180000)
Linux version 2.4.0-test5-rtl (vista@mac.vista.com) (gcc version 2.95.2 19991024 (release/franzo)) #8 Thu Dec 7
10:18:58 CST 2000
Boot arguments: console=ttyS0  root = /dev/ram0
Kernel command line: console=ttyS0  root = /dev/ram0

/snip/

RAMDISK: Couldn't find valid RAM disk image starting at 0.
Freeing initrd memory: 4194302k freed

/snip/

Sending BOOTP requests....
IP-Config: Got BOOTP answer from 192.168.1.3, my address is 192.168.1.5
kmem_create: Forcing size word alignment - nfs_fh
request_module[block-major-8]: Root fs not mounted
VFS: Cannot open root device "" or 08:01
Please append a correct "root=" boot option
Kernel panic: VFS: Unable to mount root fs on 08:01
Rebooting in 180 seconds..


--0__=862569AE007523048f9e8a93df938690918c862569AE00752304
Content-type: application/octet-stream;
	name="pic23967.pcx"
Content-Disposition: attachment; filename="pic23967.pcx"
Content-Description: Paintbrush
Content-Transfer-Encoding: base64

CgUBCAAAAADzASwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAB9AEBAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAD/Hv8e/x7/Hv8e/x7+Ht8ezx7IHsQewh7/Hv8e/x7/Hv8e/x7+Ht8ezx7I
HsQewh7/Hv8e/x7/Hv8e/x7+Ht8ezx7IHsQewh7/Hv8e/x7/Hv8e/x7+Ht8ezx7IHsQewh7/Hv8e
/x7/Hv8e/x7+Ht8ezx7IHsQewh7/Hv8e/x7/Hv8e/x7+Ht8ezx7IHsQewh7/Hv8e/x7/Hv8e/x7+
Ht8ezx7IHsQewh7/Hv8e/x7/Hv8e/x7+Ht8ezx7IHsQewh7/Hv8e/x7/Hv8e/x7+Ht8ezx7IHsQe
wh7/Hv8e/x7/Hv8e/x7+Ht8ezx7IHsQewh7/Hv8e/x7/Hv8e/x7+Ht8ezx7IHsQewh7/Hv8e/x7/
Hv8e/x7ZHskAAQQHDtoexQDbHs0eCsQABx7EAAQe/x7/Hv8e/x7/Hv8e2R7MAAEL2R7FANsezR4K
xAAHHsQABB7/Hv8e/x7/Hv8e/x7ZHs0ADNkexQDbHs0eCsQABx7EAAQe/x7/Hv8e/x7/Hv8e2R7F
AMIeCgPEAATDHg0HDMIEBwgOxR4OCAbCBAwHCh7FAMIeCckHCB4LxgceDsQHDcIeCwcGwgQHCsMe
CsQABx7EAAQe/x7/Hv8e/x7/Hv8e2R7FAMMeB8QABB4LBMcAAQnDHgfHAAQexQAeDgHEAAoCwwAB
HgrGAB4KxAAKHgbHAAzCHgrEAAcexAAEHv8e/x7/Hv8e/x7/HtkexQDCHgsDxAAIHgPKAAoeB8gA
BB7FAB4GxAAFHgzEAA4HxgANCMQAHgbEAAQCwwAHHgrEAAcexAAEHv8e/x7/Hv8e/x7/HtkezAAH
HgjEAAEJBMQABR4BxAACCAoJBx7FAAvEAAEOHgfEAAoGxgAJB8MABA7EAAweC8MAAR4KxAAHHsQA
BB7/Hv8e/x7/Hv8e/x7ZHsoAAgfCHgzEAAUeCcQAAQ3FAArFHsUADMQACMIeDcQACATCAAXDAAcM
wwAGCsQADMIKxADCCsQABx7EAAQe/x7/Hv8e/x7/Hv8e2R7MAAYeBMQABx4KxQAKxQDGHsUABMQA
CsMexAAHAcIAB8MABQTDAAkKywDCCsQABx7EAAQe/x7/Hv8e/x7/Hv8e2R7FAAoOB8UACwzEAAUe
CcUADcUADcUexQAKxAACwx4EwwAFwwAKBMIAAwHDAA4KxAACxgQNCsQABx7EAAQe/x7/Hv8e/x7/
Hv8e2R7FAArCHgHEAAcIxAACDgzEAAUeAcQAAwseDgoexQAeBMQAB8IeB8cAHgzGAAIeDsQABMUe
Dh4KxAAHHsQABB7/Hv8e/x7/Hv8e/x7ZHsUACsIeBcQADA4BygAJHgfIAAQexQAeCsQAAQseCcYA
Ah4HxgAMwh4MxAACDAcFAwQeCsQABx7EAAQe/x7/Hv8e/x7/Hv8e2R7FAArCHgfEAAMeDQHIAAbD
HgTHAAQexQDCHgTEAAweDsYABR4KxgAHwh4OA8gABB4KxAAHHsQABB7/Hv8e/x7/Hv8e/x7ZHsUE
DcIeCcUEwh4OBwTDAAMMCsUeCAUCwwAEBx7FBMIeCsUECx4FxQQIHg7GBA3EHggFAcMAAwUIHg3E
BAgexAQGHv8e/x7/Hv8e/x7/Hv4e3x7PHsgexB7CHv8e/x7/Hv8e/x7/Hv4e3x7PHsgexB7CHv8e
/x7/Hv8e/x7/HvceGsQUExrPHh3EGsIfxBodHh/EGhXOHscewx7CHv8e/x7/Hv8e/x7/HvUeFBjH
FhrOHhTEFsIaxBYUHhrEFhnOHscewx7CHsQeGhQcxB4UE8sexxQd8R4fxx4dEcIZFB/SHh//Hv8e
/x7/Hv8eHw/JFhrOHhTEFsIaxBYUHhrEFhnOHscewx7CHsQeEhYYxB4WGcsexxYa8B4cEMYeHRfE
Fg/RHhwQ/x7/Hv8e/x7/HhnKFhrOHhTEFsIaxBYU0R7JHsQewh4exB4XwhYVwx4UE8sewhoUFhLC
Gh/wHhYZxh4SFhAaHA8WHNAeFhn/Hv8e/x7/Hv4eE8UWFxMdHhUTHcIeHREPwxYXEBPDHhTEFsIa
xBYUHhXEGREeE8QZFRwYwhYQFcMeExAYwxYYGR0ewx4cFg8WEcMeGhXCHhrCFRQfxh4aFhTDHhrC
FRQfHh3CFBzCHhrCHRQTxB4awhQVwh4aFR8UEx/EHhMUE8MeGsIVFBsWDxrFHhkWH8IeGhkTGhXD
HhUawx4awhQVHhoWDxrCHh/CFBXDHhoVHxQTHh0UGsMeGsIUFf8e/x7/Hv8e5B4ZxBYXFcceE8kW
GR8eFMQWwhrEFhQeGsQWGR4UxBYRxRYXHx4SxhbCFhoewx4SFhUXGMMeFhnCHhYPFxYfxh4aFhTD
HhYPFxYfHRfDFhEeFhAXwhYRwh4UxBYTHhbCD8IWD8IeHw/DFg/CHhYPF8UWxR4SFhgTH8MeDxYf
wh4WD8IeFMQWE8QWHh8PwxYTwh4WDxjCFhIXwhYcHhTEFhP/Hv8e/x7/HuMexRYRxx4dyxYRHhTE
FsIaxBYUHhrEFhkeFMsWHBXEFhgSEBkWGh7DHhcYHhIWFcIeFhnCHsIWEBHHHhoWFMMewhYQER4S
FhQcFxYewhYUHBYXwh4XGBwTFhgewhYSGg8WEx4UFhAaEBYUHsIWEBEUFhgUxR4dF8MWEh8eFBYT
HhwWFMIeFxgcExYYFBYYFB4UFhQcDxcfHsIWwhTCFsIUFhAeFxgcExYY/x7/Hv8e/x7jHsUWFMce
FMQWGB8UxBYXHhTEFsIaxBYUHhrEFhkeFMQWGBoYxBYUGsQWFBXDHh8ewh4aFhEeHBYUwh4WGcIe
FhfJHhoWFMMeFhfEHhoeFRgWHhYYwh4ZFsIeFhcTHx3CHhYYwh4VFhAeGBcfHh8XDx4WF8MeFhnH
Hh0SF8IWDx8dFhIeERYVwh4WFxMfHcIeFhnCHhgPwh4cFhMeFhjCHhYYwh4WGR4WFxMfHf8e/x7/
Hv8e5B7FFhHHHhnEFhAeGsUWHRTEFsIaxBYUHhrEFhkeFMQWEh4RxBYUFcYWFhkTwh7CHhEWEMIU
Fg/CHhYZwh4WGckeGhYUwx4WGcMeHxIXwxYeFhnCHhkWwh4RwxYZFR4WGcMeFhkeFhnDHhkWHhYZ
wx4WGcoeHA8WEx4PFx4PF8MeEcMWGRUeFhnCHsYWFB4WGcIeFhnCHhYZHhHDFhkV/x7/Hv8e/x7j
HhnEFhgfxh4ZxBYRHhrFFhoUxBbCGsQWFB4axBYZHhTEFhQeFMQWFB4UxhbCFhIewh4YxhYdHhYZ
wh4WGckeGhYUwx4WGcMeGRYRFRkWHhYZwh4ZFsMeExAXFhgeFhnDHhYZHhYZwx4ZFh4WGcMeFhnG
HhYYwx4aFhQeFBYcFhLEHhMQFxYYHhYZwh4WGMQUGh4WGcIeFhnCHhYZwh4TEBcWGP8e/x7/Hv8e
4x4UxRYPGsMeFR0SxBYZHhrFFh4UxBbCGsQWFB4axBYZHhTEFhQeFMQWFMIeFRQZF8QWFh4eFRYQ
wxoUFhQeFhnCHhYZyR4aFhTDHhYZwx4WGcIeGBYeFhnCHhkWwh4UEsIeDxYewhYdHhwWER4PFh0e
HRYZHhYZwx4WGcYeEBYTwh4UFhQeHRYYFhzDHhQSwh4PFh4WGcIeDxcfHhUUHR4WGcIeFhnCHhYZ
HhQSwh4PFv8e/x7/Hv8e4x4fGMoWGhPEFhccEMQWDx4UxBbCGsQWFB4axBYZHhTEFhQeFMQWFB4U
H8MeEsMWFh8eERYcwx4fFg8eFhnCHhYZyR4aFhTDHhYZwx4YFhEZwhYeFhnCHhkWwh4QFhARFg8e
whYYFBcWGh4TFhgUGBYcHhYZwx4WFxEdxB4cwhYZDxYXHcIeD8IWH8MeEBYQERYPHhYXER0UFg8U
GBYVHhYZwh4WGcIeFhkeEBYQERYP/x7/Hv8e/x7kHhUXyRYaHg/KFhoeFMQWwhrEFhQeGsQWGR4U
xBYUHhTEFhQewhYYGQ/EFg8eHhgXxR4QFh0WGcIeFhnJHhoWFMMeFhnDHhPCFhgRFhwWGcIeGRbC
Hh0YwhYXFR4Wwg/CFhTDHhHDFhTCHhYZwx4RwhYaxR4RwxYXE8MeFBYZxB4dGMIWFxUeEcIWGh4S
wxYTwh4WGcIeFhnCHhYZHh0YwhYXFf8e/x7/Hv8e5R4dGcgWGh4fD8cWFxPCHhTEFsIaxBYUHhrE
FhkeFMQWFB4UxBYUHsYWwhYYFR7mHh0azh4VGsMeFhkeGh3FHh0aHckeGhXHHh/CGsUeExYUxh4V
GsQeGhXDHh0aH9AeFRr/Hv8e/x7/HukeFRTEGRAUH8MeHBLEGRQdwx4axBTCHcQUGh4dxBQTHhrE
FBoeGsQUGh4TEcQZEhPCHh77HhYZ4x4VHBgWFf8e/x7/Hv8e/x7rHtUeyx7FHsMeHvseFhnjHhPC
Fhn/Hv8e/x7/Hv8e6x7WHssexR7DHh77HhoV4x4dwhQf/x7/Hv8e/x7/Huse1h7LHsUewx4eDJAC
KZcTN54jRaUzUq5GY7VWcMN3jMyLndObqtqruOG8xvHf5Lxnf+rP1/jv8nt7f5KSlaenqp2doL6+
wLS0tuDg4VtcYGZna3BxdYeIi9PU1czNzsjJyurr6/////X19QAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAPCHFwAAAAAAAQAAALhtYQAAAAAACgAAAAAPFgBBFed3fgYbAIMA
AAABAAAAOx7nd34GGwAFAAAAAAAAAOYBGwCAAAAAAAAAAFjgYQAoACoAQJUXACgACAJ4lRcAAAAA
AAAAAAAAAAAA5gEbAAEAAAB+BhsAiUr2d0gFFAB4+hIAAAAAAID6EgCjGOd3iUr2d0gFFACI+hIA
+Ov9f4lK9ndIBRQAmPoSAPjr/X8BAAAAAAAAAAIAAABIBRQAkPoSAPj7EgAAAAAAGPoSAC006HcM
JN53FAAAACgAAAAAAAAAQJUXADiVFwAAABQAAAAAAHj6EgA4lRcAAAAUAAAAAADJwfZ3GAEAAMrB
9ndABIMAUPoSADiVFwAoABQAQJUXAHxM9ncgAQAAVJUXALgAFAAAAAAANQEAACABAQDA+BIAoPoS
ADj7EgCU/vh3QLP5d//////8+hIAHEv2dwAAFAAIAAUAGAEAAAAAAAAIAAAA/////wAAAABk+hIA
GAAaALD/EgBIsPN3KMrzd/////8BAAAAnApFAECVFwAAAAAAAAAAACAAAADwman1bpG+AfCZqfVu
kb4BAMv6i7KQvgEAAAAA0gcAAAAAAAAKAgAAYWlyLXRyYW5zcG9ydC1zeXN0ZW1zLW5vdGVzLkj7
EgDzKPB3AAAUAAgABQAYAQAAAAAAAKhySAAAAAAAZJUXAAAAAAAAAAAABI9DAGSVFwCsBRYAQJUX
AGiVFwDQckgA/////wAAAACAj0MAZJUXAA==

--0__=862569AE007523048f9e8a93df938690918c862569AE00752304--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
