Message-ID: <39FC9932.6041E947@noos.fr>
Date: Sun, 29 Oct 2000 22:40:02 +0100
From: Guillaume Laures <guillaume.laures@noos.fr>
MIME-Version: 1.0
To: mlan@cpu.lu, linuxppc-dev@lists.linuxppc.org
Subject: Re: Keyboard trouble with XF 4.0.1
References: <200010291647.RAA01482@piglet.grunz.lu>
Content-Type: multipart/mixed;
 boundary="------------3BE43FB79C3853C9F97A66C1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------3BE43FB79C3853C9F97A66C1
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Michel Lanners wrote:

> Hi all,
>
> On  22 Oct, this message from Martin Costabel echoed through cyberspace:
> > I can tell you what is working for me. I have been using Franz's XF4
> > RPMs for quite a while without major problems (some minor ones still
> > persist, but since the RPMs are 3 months old, I won't repeat them here).
> > I am not using, however, the "linux" keycodes. Only the ADB codes.

You have attached my answer to the problem we seem to have in France
regarding the new input layer, since no good azerty keymap exists in the
standard distrib.
 - fr-mac.kmap.gz: a map to use at console (place in
/usr/lib/kbd/keymaps/mac/ and run kbdconfig)
 - xf86_nil_fr.diff.gz: a diff to stuff I modified in the xkb directory. (do
not try to apply it, but inspect it and see what should be included in the
distribution, test it)
Basically both are last Marc Shapiros's production, with various enhancements
(not much...) and with keycodes # completely redesigned regarding the new
input layer.
Note: you'd _rather_ use linux keycodes if you setup this...

I have only one problem so far: I can't switch from X to console. Otherwise
it's very neat.

>
> I still don't see how those Xkb options relate to anything in the files
> below /usr/lib/X11/xkb. Anybody can explain this?

I've yet to find some doc about it, but starting to play with rules/xfree86
made me learn what you can see in xf86_nil_fr.

Last but not least:
Section "InputDevice"
        Identifier  "Keyboard0"
        Driver      "keyboard"
#        Option      "XkbDisable"
        Option "XkbRules" "xfree86"
        Option "XkbModel"  "macintosh"
        Option "XkbLayout"  "fr"
EndSection

All using XFree86-4.0.1-0.36a and happy (so faster with r128).

And an advice: if you plan to move from XFree 4.0 to 4.0.1, have a clean
linuxppc install not far (other partition) to recover things once your
keyboard is completely screwed...

Later,

--
GoM



--------------3BE43FB79C3853C9F97A66C1
Content-Type: application/x-gzip;
 name="xf86_nil_fr.diff.gz"
Content-Disposition: inline;
 filename="xf86_nil_fr.diff.gz"
Content-Transfer-Encoding: base64

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
LAAA
--------------3BE43FB79C3853C9F97A66C1
Content-Type: application/x-gzip;
 name="fr-mac.kmap.gz"
Content-Disposition: inline;
 filename="fr-mac.kmap.gz"
Content-Transfer-Encoding: base64

H4sICBVc/DkAA2ZyLW1hYy5rbWFwAI1Z3XPjuA1/Vv4KNnnYu/ayteQPydfZ7uXLnZ1ukp1k
25frTEaWmViNJHolapPcw/3tB5ASCVG0Wz9kQgAEfgABELRPWJnW2ftmm+7yWvySV3Wevn+s
2exUZFKseX0aLpfJ0Qlb1bzKtuw6zfJKimbLnvnbWqT1BniplLzcSSYFS4v8qcJ/5JazRqbV
BkRwFyt5WuXVExOPuLV5D/tK0cjijYHCNpf5d/4noImdzEX14ayQ/6j/xs52u4L/9UKUJWhC
Ivvhw4e/gy6Z/oiGN+lO8k1vr+IvoGzXSlakb7xm6zf21OZFkbYlfw9/a978UgnRoINRYjyM
JpPJEWj7ent5+zO7uL35enf7mZ3dXLLrq69nQLg+/3Rz9vXT7c390VG2TeuGS3acN+I0SebL
0/D4CBwq013DJqfLn8LwNIyOkJSJDQ9C9oFdNVm648FREKSFDDoOA05wDY48aPZR0GzzR4ki
bJ8IgAwbyWrxYvQnCzCQyiAIqrYEbxqIv2MIRbSaVAIrE5WsRcEGGmB3QRB49hL1vXHGIjRe
7oAO58O6j6j4EEEQGQC9LPV2LIYarJEpGOFp1krO7Ee+CA/eYNqrQL4J0gw0fGsFpMq6CKyK
bc0dpGzW7+/FfUaMkNZgzMwxGjtI6lrstrw39Cja2rEyN/Ew0j47RkypMGbwvHYp1GPBYUPv
zSMUEKOfdZ1mHEVYgP8+c4kLB4k5XqPQB8RIoRHMwj/DB0qt4bVUxfgT67LKnloMKBueYTVT
VE3+ChDGJuLeBApYLQme/VOdDnxr+Hc+UKqqnJdCeRiYVZ0/baXXWmKsoSob2iWae82KtOzj
yjsdNGjLfrcW9UXMiqj91qFwAiayjG+wLxkHoDNyL1AU7+ovHxRFiI0ldSPzG6+FX49pJUrE
tqeoTyYVrCDYQLQ5UamySPFMGtWekITRIJHqgddBiCVc5lXbQJ9qqw30gEzUbu2FpniVaBdW
NpBRQkxLUUXaY6e1aY0XmkjFLTDsDJdQJbIDgy4TY6bSexnbtfCzXxBqJIKOiJ3aGsP+8DVd
B9YU0YBMpQEk9tsZSJFsULeA1vtUW/8VmcJ2mWdXRAmW7G9krYqPrLE66t6IPTYkZ22NA8Ib
uRow0SVZY8JSPmZeS9Z4sDlZ49EIskbXd/TuQfwbnm4esrzO2vKx4K+Yv0DY5CmHyz5v7HVn
Lxl13fVJkTZZnuv99qAiDMRGQIHWkK9pI6EAmufg3yLf3L+Va1D2xt1LNjINTG/0XecjGWsR
Q33HZVtXAebOdJg6jM1R4AJmjIfPInsmdyNG+RtZY5QbssYob8gao/xI1hjlJ7LGKG/JGqP1
X7LG0FD7iAsuSTcpFL0SUo8jOhQ+kTVE4URH0sPVjU9rYSfsUvCmeifZi6ifP378SPvuvs1r
EmVAi6laEsIMw9eqLhoEMJpkvPJegDPThnshomPa56HuxgHmSwGjLrgl909lM9Pt1DaIwnj6
sjK9TojChkSBfRyVo92TykHheyToTHfCZnJLR0vwDJPnHjVQdzHDCt40LAjgqkgBmDPtzcxd
g2LecIbWd62B6MeMpCAwI1/JGjMyI2vMyO9krdKKKsRD/0sVBDddd5B5seGezoCCpjFUzp2y
V2romLn3K6/fhG2nRjUR4BMHquhbyxscmdyB0eSfEvRNz0TGKvG6oCX7i8rAUJ2Dl3kmCgHR
wnLIxcYFEtrJqRP1dTor1mmxZiLlrTbRFGmzhVPJv+cN4A3WMF8omms1su4PLdq72sp0Gmjq
u4eohPtDtFYtSvXm+NamBcShgLEF/3RTyRCZqSUl7UNmRVAJ7ekzW14nbO5WX4R522FEgVv1
MsYQ/0x0qEscH8soMnguO5KhukBBlCJQQ/oOJryj0eykmepZOBpDFEvHWm0G03dqRDwMYNED
6MW9LoWTifXJUJfxMBrvHqt37Ic3XhTiBRXAk3/Ni+ZH5D22VdYrpgEH4BjTVciGn1XoUMBO
Iwr+EE49cTFaPIHpeGa/2f5/iBLOAiOwikYwHYrZO/PC7LR4YSpevz86CNMRNZwFNozVdATS
oRiQcw/ITocHouL0e6cHADqCFDi2mtVsBNChGIALfxS1Fn8UI2J7djiKQ1ELHzvNaj4C6VAM
yNgXRa3DF8UpsTo/FMWhoKVjj1otRvAWe+AlPnhahw/ejFhdHII3FLR07GmreAQv3gNv6YOn
dfjgzYnV+BC8oaA99gW2vFUywpf48UUTXwp2SnwZqFj97uRQAjqSNDOxs66WI4wOxWAM/WWi
tfjLJCa2l4fLZChKOGyRqK47cXBGDsHgjLw4jRovUs016TI5iHUkbPMBO/tNWzqPNfjE2Ezv
M9BYKKbGfL8VLw/XvBT1GyHc8acc5/7G74hWhYL3MsXvJnwQXXsGTKhe+3posZcsOvTPLw+X
MJBtyMt/Ptf067aQ+a4gr/g41Bxf+SjeGT6waU3Ekd7hy2fF0ztIisZTvcOXXIqnd5BsiWd6
x327lnWakW8h4s4TXz9XPK2LNOh4oXf42qvi6R2kZ8ax3uHreIqnd5A2FndxP9uQp3q81ETf
nKF4Wg0ZHJKJ3uG78hVP7yB3eNIdn+8GTuzxkWs16Y7PVz+JPT5SDEl3fF/USwD/U/MhPHj1
91GMjbJbbTkXQtrMHxszMjbfE9WE3Glu73gXece7XomvoBLansKD450rSqsy0T3IGef2zneR
f74zavylnwy60+EZbyRsW0KX/lcVPtPtljAiAzl5QnmA7hUdA9knSg1PMC/Pa54OOms4UXNa
XpEKCieYI//aDeWwN3yBVOy/ohtGQvO7jnkOAF7wN06iEpvEZ/ydpD+l8Ze0SuaSZ/VDF1G6
H+OpXj+HFKDQp8qnALkYo3t4vtPGFk7wBC/FS3VIL8p8Thvp16tuLf4q9wRmaQOzEvUwLviD
xESBxt+EhnQ8rzu43NSXXHtrvpf8H2U/EGtkjd+JrZBw/J/JdPrrr2fHhhpZ6rmlTi31wlJn
lnppqXNLvbLUhaGG8e+WHFtyQsiJJS8JeWnI0YSQVRA7ekjp1sVoSunWyWhG6dbNaE7p1tFo
QenW1YiiD62zEYUfWm+nA5zW3WlE6dbfKcUfWX+nFD/UsY2bpev0spAsRyeYVWY5ulIMh1hR
XcAwSJiwCAydhkn9iHFM1pGznjrrmbOeO+uFXv8B0b60dYchAAA=
--------------3BE43FB79C3853C9F97A66C1--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
