In-Reply-To: <19981223043717.005394@mail.mipsys.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="==_Boundary-1_=="
Date: Wed, 23 Dec 1998 10:23:27 +0100
To: Paul Mackerras <paulus@cs.anu.edu.au>, linuxppc-dev@lists.linuxppc.org,
        Geert.Uytterhoeven@cs.kuleuven.ac.be
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: [PATCH] new offb.c fix
Message-Id: <19981223102327.016345@mail.mipsys.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--==_Boundary-1_==
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Enclosed is the latest version of the patch. I updated more pieces of
code here or there so that offb.c can now theorically work in directcolor
if the cmap_adr field is present.

However, I still disable this feature and uses the ATI kludge only in 8
bits since there is a difference in the way the color registers must be
programmed between different models of ATI chips, and this broke for
example 16 bits on PowerBook G3 Series (LT-G)

It still missing code for getting the default palette set by bootx but
this is less urgent. This fix was more important since I would like
everyone to be able to boot in "no video driver" mode, at least for the
installer. That also means that the installer could be packaged with a
kernel containing _only_ offb to save space.


Note: Geert, while testing in direct colors, I had a funny problem in 32
bits: everything was fine except the console cursor which had a different
color on each virtual console. Since I remember reading about similar
bugs in early versions of other fb devices, I guess it's a common
mistake. Do you have a clue about what's going on ? It's not very
important since we are always in truecolor with this version, but I'm
curious ;-)

-- 
           E-Mail: <mailto:bh40@calva.net>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>



--==_Boundary-1_==
Mime-Version: 1.0
Content-Type: application/octet-stream; name="offb.patch.gz"; x-mac-creator="477a6970"; x-mac-type="477a6970"
Message-Id: <19981223102407.006681>
Date: Wed, 23 Dec 1998 10:24:07 +0100
Content-Transfer-Encoding: base64

H4sICEbQgDYAA29mZmIucGF0Y2gAtVfrU6NIEP9M/oq+vaqtIGCAPE006mq2zjpv
tYzeaVlbFIEhTomQAqLx9vzfr3uAvCTRnHt8YIDp1/z6RWuaBj4PxpPtMOLDihvx
RxbFlUfusrASet5g25H+CAM4Zg4YNTCr7Vq9bTbB2NlplRRFyZhd9ljM+xdzBa9Z
BcNo1/S2WUt5Dw5Aa7TUJih4b8DBQQlKECd2wh3gQQKhFwb+M+yB3sEdrQR0VbbS
FbYAToKERZ7tMBjHqGTwDMkdg6cw8t2cqCK0mHVDbYFi1nXV0IUiupgfM+AelL2B
5fJ45NvPt04YfN92HuzRts8CGbVBgEd3mWeP/QSc0A8j3NwnwSAhnxOOni2iL38u
kqJCer+PRw7sgw5tMOXOTH1JWxRCMlJd6buxu7ss9tGOtgc8ia0Ri6wRnzBfVlGM
JGQWalNo50dJkQjUmP/NENK3pcLeHhgNFFM1SU69gYLWG0ui5RUnFja8pAePWDKO
AuFV/JI6qKkLBzXJT+QfKSPSet/O+jd9CgDBS+76ZbW/fkjCY1NHge37oWMnzBUu
0yTiL7MoSiEQu+vcR8AitO9ygwq6LMs/BeYNrRTaMvUgzUGMIrJge5nBh3yk1BlH
ET7KeD7EjN5YQBEexKHP9vPMqZumaqBn6mZVNWep4/GJ1k2eR3TGr1+sy5vznnV+
ePR779g6P7nunfY7S3SWPZ5MM5kUXl9fw70/docMvDACTHrhoNzIOIkC52FUDuwH
PNmnw8sb9ZMKNZks19HPKGQcxHwYYN77YTCEgR2TMbbrRiyO4TPoE8/TxXV12iHP
B16odQkvy3YJWR5GjDAVnArSNwUD4jgxcJXFN8fRl5hdO7GJe1GcAkYntf4lr1R0
DJeNkjuyuSVTqhMajzwe2/5rCfsE5J8n/avDU+u837s6Pjs6Oz27mGYvLauBS7ff
hZwibQYd0n8Au0XuNeAp0kt6imncbIoUiFylqz1H0b88vDw5midcrEZ5GV7QOGO/
vLjq5VxLRJWtNYYdn1z0ji4zF84ZtlUplJ2VN6wPWneCjTNmCWoQr8/TV70zR7Vc
RkDEWiftqoZBjU5pGDUVW3aetflFFUTr0j1+QkYsKpj2luMNjEZnNeWi8zIeqrxF
jBSaZS5sBg67WOJwVRTKAqlYwC3/Dnt5IyuXy3lrGfhj2up2oSqL2DQ8GXZRIkbZ
PwX0wygopK8vkOfUEXNfUXdmcTjNqgXPF8YHVX4hfN3xFGnD8xUwrD3gjP6NE0qS
CPxNbOZTs7Jn0gh8yfODiNn3+O1XFrjcw5V7aAoidnT2zfrtsG8dff1SNdMwxeay
g1Fq7mwUpVXzP0bpK8ZNo7RqCkhg2XmESyOLrxytJXchSWuRYtFB/0PQZdYKB660
eGFzyVbae2Xl24Ezr3cucBqzwGm9J3Cm3k0taIuQae4YNDC09CouecSQEabWHdk+
SxJ2G7FhEH7fHkaM4Z8OiLWzjhIxoQZIi/g/IcqtjHSu6QnqzE8rt7FDnwUQhw8M
nDs+wsIdq9Ra6dhV1A9GHah0iwmCrgfbubMYZzws55PBgvAsnhH/ThEDgdLSa/T3
3DIaGShS/MQT5w7RTgUVzAz4I1CYmkYj+4V0qLUbjXaeC2ZBfUjxo4QQT3P1Yfpe
nwW9NEXwwxJzSdjyN6g3LbMpcKq25sfAtRNgOuWhF9f+fxsq0LBLdDh5oG2qiLTX
k95U0AcGvTSpVqv8uePeSouzae8NO17SGQ9K/wIG1an5ZhAAAA==

--==_Boundary-1_==--



[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
