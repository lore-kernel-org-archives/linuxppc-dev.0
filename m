From: Benjamin Herrenschmidt <bh40@calva.net>
To: <linuxppc-dev@lists.linuxppc.org>
Subject: Re: MacOS X and yaboot wars.
Date: Tue, 26 Sep 2000 14:12:47 +0200
Message-Id: <19340821054431.20797@mailhost.mipsys.com>
In-Reply-To: <20000926004845.T1928@plato.local.lan>
References: <20000926004845.T1928@plato.local.lan>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="==_Boundary-1_=="
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--==_Boundary-1_==
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

>
>ybin could not care less, ybin will install onto a regular file
>happily ;-)
>
>what DOES care is OpenFirmware, which insists on it being Apple_Boot*
>Apple_Boot is used by apple so macosx will do whatever it wants
>whenever it wants, Apple_HFS is out since macos old will ruin it as we
>have all seen.  Apple used to use Apple_Booter so i would avoid that too.
>
>i think the best solution is just reorder the partitions again after
>installing OSX.  using Apple_Boot would probably just mean your
>partition would be erased instead of moved which is far worse IMO.

Well, I know Ethan doesn't like this solution, but I personally like it
and feel it's ok for people who know what they are doing ;)

First, I have no bootstrap partition. I have a (around 1Gb) HFS standard
partition that I use for exchanging things between Linux and MacOS. On
this partition, I have yaboot, yaboot.conf, the kernels (but those could
be on ext2) and the OF boot script.

All I do is to configure OF manually OF to load the script (setenv boot-
device hd:10,script) and that's all.

I also have a fake System and Finder (included). Those are seen by MacOS
9.0.4 on my box as "legal" system & finder and MacOS will not unbless a
fake system folder with them in it. (In fact, it will even re-bless the
folder).
I _know_ that this doesn't work for all combinations of machines. It does
work for me (Pismo). Basically, my setup looks like:

 /Scratch (HFS exchange partition)
   |
   |-/Bootstrap (fake system folder)
       |-Finder (fake Finder)
       |-System (fake System, could be miBoot for oldworld)
       |-MagicBoot (OF boot script with the type/creator of
       |            a MacOS ROM file (tbxi/MACS))
       |-yaboot
       |-yaboot.conf
       |-kernels & ramdisk

Ben.
--==_Boundary-1_==
Content-Type: application/x-stuffit; name="Archive.sit";
 x-mac-type="53495435"; x-mac-creator="53495421"
Content-Disposition: attachment
Content-Transfer-Encoding: base64

U3R1ZmZJdCAoYykxOTk3LTE5OTggQWxhZGRpbiBTeXN0ZW1zLCBJbmMuLCBodHRwOi8vd3d3
LmFsYWRkaW5zeXMuY29tL1N0dWZmSXQvDQoaAAUQAAANIAAAAHIAAgAAAHI0Sg2lpVJlc2Vy
dmVkpaUApaWlpQEAADYAALQEWcC11wdbAAAAAAAABdsAAAAAAAZYGAAAAAwAAAAMuG0AAAAA
RmluZGVyAAE0PEZORFJNQUNTAUD/////AAAAAAAAAAAAAIAAAAAAAAAAAAALOgAABPUAAAAA
DwBCwdTAJ7TwFRmcnSuIVCcS+DGE5mQdnzsRftMuX0LHmp0bCzZCS41E9/V81ZeLRh3Du+5n
UvYrOuHUna4QfkhktLAwc+O53cWoelpTvpJs5u0WhNcjWDQWHyQgl+w9TTRHpq2SIouXyn82
lVcuH72LzJ6ghkI5kZA/sPrpAGy1CVZsNrZe/m+i8vRF34LfrTc40M7Y/bgI3/KoMzErhP60
7BgpuICHYXBMgZ1Em/b4v2g3C/3wNNq6J71aVEtXPhSoBkPzmXuGKcM51qFzJ6nBpufk6eAW
7MpaBH60AzQZMrkNJDi4n2j6AFzTnQQPFcr6m1x7mIN1KWqkya/Fg0Ql7WgGxOlx8x1jlQVE
yWj2VgL1LVpQ26xpB0JveFtPokzV/eH608QauyjmbFoUk5SnAW+FiGEZkxeTQgUFYs4bwLb/
WseKjT1vRbJUl+FhLSf3vsxxyt8I/da70zuQi2jdh16rkPvIGKYvMCEfs1J2Ke0egwRsHwyX
X6F9p7t5iLnh0ZWTuY1sIz8yUB6LQVqShNkuvh3wXs7at1+ZmVc3KIVAAe7fn3dpzyUloMJV
7Sp7qhxTD0LqolWcY4SjCIZIHCQvA+Rzv5P+xTd8xeblyhmuq5RZ6y69xd4Nc3VDPSZcRqrk
vh8WMBHKzdeKM9sHoiWAdCN/F66k4D7eRBYeGpUOtrNF1D7sceSxYbJhjTBlSorlirasDrJ5
wOnbkDKgvt2yrRFCzXqhlMu9F6j+qFPu7VtpSn/wPjvwWlgd+w41M7MAMdbeAw1/2u2WULc6
k5EbuwDYPHmIQRZHqjcq+AZcxrdsJxPn0HzEk+96/RJpmFtAfsYiYNlGlFFbRilxmiJCUv/b
nWx3mGKBc0Kiuze+f41R5Ek1SbFnl0Nyx/O+Zqq66zca4Y57nLBJMcp/ZF2L/DxR2+t7tF3V
DxUWpoDtcrs4hsQtUxaGHHY7EcDZJaAy56WV6ZuX0bPaIPQ2O/lZndTp1CwRl5RixgGCGAsg
WCvKR9+1Ak90He8ZqpmkevIeyH/i6OChN0/XhLaWFQgDnacMfAn+C9DGSEbWqKmKg80jSwu6
BexzjPZ7OT5Bq1UgwdYrx1Hq16XZPuNrmJ6ImDW/jI6kxXhivL4sPPSDcuD275zs9f12cEUz
l03BOZv5fOLSnjHvRd2UqJFcWrZyln9eYghFeB7CYwdxUesgiucTiFFtBUtkvOMRiXIJXD1q
gSeOIpDCrLI6yqV1IMfCuK7ZWoV6G/BQsq7MQlfNM9zSSfNNJ/9omLPBsYVjCsjA39ObpJOs
FjzS06vTWXiEQFyACAb3l6gMxcUvU1/Ti3DGzbWRY0Q5qAz0k3mapm4lGcAXeNO7BZ8NlfO3
VdlUPzJ3jbwRXk+uWX2S6JGDLBtjnbOQFmHm1g8osdVWmmkBdiLSCtZ8RXqZdPKbDa9k4J16
QnWLDDj0TpXe6sun8eCx2ulveQkKWotT9MWwhNelvs8xE+VIArRYdF4FmIbpq3vTRxHZFrab
qdtEJ9NolPIvg2lJ8KMwE9kn0nqKo5WaPq7U4KmYxBcE8w6dzt7BS4lmJUnuox7IEVV9JKAa
oTP+4fWdvDZp3jtoGPet0j+eWAZ5FD+AYtOnmi0EWV/K61BlQzOjSX4VcDEDxS9YOPJCQ4Pi
SFiKA3OBuIjNxJBcFrQB5gdqblQOhZWGixVAUABKb3khcGVmZnB3cGOlpaWlAQAANgAAtBLa
QLXXByYAAAByAAAAAAAAAAAABn8dAAACAAAAAEwAAAAADwBTeXN0ZW0AAQgQenN5c01BQ1Mh
AP////8AAAAAAAAAAAAAgAAAAAAAAAAAAAwAAAAGkQAAAAAPAELB1Mk4icf9OlSn65rxoRQq
wMxjEN4q1ZcItEoq7+qirI9Qi/xq4T/dLwiGNH7ENXCd42QhbM/pTXUCb7GLNY/dn0HXLsR2
S1m/S+IxpZNdo5LS2/ifrA7n42pJvB00jtJCQ5ubYDSPsrl6XaGvIR5phe1HVIDfONoqEvN6
c0bH98wr7lzQth+waTs58YGgwC3l5Ky8VZ0dJSnjT8mIhruFLCgDoBNQRZ3mZXMf1IsP8Ayi
V7h6zjl/oYeR4+Gji7+1Hofn03l+s9I6K1JbxnZvEnRoLaAZ5dSPuxdf2uDPsT1GtiBzjojM
PgDrNht82DdkJTWZoTAHzp1gPOPDsNccg/lObjT3UI/fPf5PQ9uxfnDEonrHj7tkEmDO9wYT
r22dis7fk/heSYcKkvmwnAe25lEEygE3H3aY57saFk9NW5aCxonskZkKXyYdeBgBQDtc6UNO
fvcFx2DrJ2+FXIjzNZutX3DFpijaZuQA/KhhaHpN/AWrQLqMWwbDddsAfBLTS/VHCYsr/0Bc
FCrghRevsmGTAJDsNbSbEaG6k2TMb/zoXtVXfwQ75V6i31KJ/iBg0M6iE2UFPPdddrSGDm1v
t2QRpRyPVyzNEL5BlHwivLFNppIZm8SUFi5wo9+3I5H6yKNnDTYneg0h3v0QEA54jjj9tRnU
XjtfGbkLSs3W0dnQZE1TCsWK0QorYbJ8eKk1AXarQF1RGz/CIQpM32dWZ1y1IS+4irwySbn8
+uaCETF3NZeq8fCv2KyoDryqDwGFEJclzxZp9Xu5/XZpD6h0lPxNwn3TxSnAoX8yU5ApEPfZ
EwQhUhokZYVcqyt668BORU8eM75n6bXZPZe2T1s/kH1j2hEzzBYw/zEXdQcpZqvSPrg7L6sn
sf6+n24EGYJGMyehFi0q2fSrVFt0ZBlP4OciT+CAfRjj0sbfKgMTLVT0wa0w400SXcRUAGyv
q4B5dGCQoVtxh0LEGJd5vq8bXuW3U8d3nJ393dhbgVDfLV67lkwitBPU4C15lxXIHM+Ydvcj
OJzG0zK+4k6NyNuX17UsQ/l/YOcGdpI61rOgLenpm9vtQV+hBBN49Yb/mzaMLxIt/S4VmeR4
naCKIz8sKnLRU0E1lSDE0sCG0vy/9Q59BAFzFmxJ0HqwMVXfgiiWYKEHppDU/RtbK7Slw87U
yuGMaVzFl3rJMbRQRi4CCB7vUAco7Gbo+YLXW235mlir4KO2fUy3Sqi6X+lgc3VMscPiCVbm
sVyIalpNGpjKuBnEFpv6jKJTRR0KTAlcMnmMPwejQ6KPLYHwvgLDtccQtpICFC77KUg6Y17d
sKryXMmu4TV5ZP8iX01++zKyfN4R3TcsXOHI+2vJJJ9lIXABkKi58+NlpfBSrMpTWr5hP3Rd
K1iGgvEWdY+nqvMRw8Ho+IINVjbpPIJN/uzSHnC2CB/Hg+yQn19zpjCoVqjlrfYvMKK8MaE+
Xr0N1NxUm5IjwK65GHdZS6dkn1Zav1/UYQnnmrIBjght+XviVpHlCskqzV139crfLvMrvRzh
eB6XTTpJ/ThlwiIhV+o6CD6p1Vg+Yt4/m1ProW4MNPuiI2UCOVfLeUawklD8f+SC8FTpSb6u
+XXQNEXP6BQHp8xixZcja1fsvIefQNE+dsY7TiuWwyoZoV9EGbd5FxjoMvk2YbTwEdCYgpiw
25LKAW+LooXvHeRcypgQt7p/pPSyfIGveo39v8zK5rtkJ6hHdFL0UwjxDMEf0VG0PZ381DgE
TyTeKzicUwtKFr3RHk4ls1Dekp+2b/OLknbSpWxg8uFIa0pM67VmUI3I6qXPiG0pGqevbhlu
1agqap7NdzFOP7YLXgiA3QVTJud0CdbEKi3yAMiWhXdjs5wpmdbcavqPR/oLo9ErH6R8Ivyp
rq8UQ9/vTwzBbdkNOe8IWpa/fku85sA20qBzcNkQGcro9t+PmSCWErmtVXTMRJ/qxaTvaYZ2
8KGliL+gxKViTqtNLKCPif/HxVefsuRnsKCXGqbJRdgH7eWny7NTC9VZv0kRka3eT6J3UIv1
8x4cFVEAzcLzYPyAQ+p2Es6tU9KokXg7QazAHtrRznhO09GLVBVFoRYowKbEcBS8M+YQgNxS
wLWvHecxliC/mowQoxCsdPOZsUFD1VcTihQ/1YqVQHNFE2NhgbzIs0GAybHZFybZRHlR0W20
F2XBJyRDnJa4c66TpSCN5BuA13+YE6NCAl9dfxBIGB5tahny7D+4zHLT4+BCwdS+dIVf6Pvo
/iciJybS86E5amTAFic02Uyl7PWEby2WxP8kGaJpZBS6iv/LVGbzEGjKF32MOgnF/BjMXrfN
dBU9n2HTnt2MgkIA
--==_Boundary-1_==--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
