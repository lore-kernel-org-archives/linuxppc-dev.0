Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="==_Boundary-1_=="
Date: Wed, 23 Dec 1998 05:03:55 +0100
To: linuxppc dev list <linuxppc-dev@lists.linuxppc.org>,
        Cort Dougan <cort@ladron.cs.nmt.edu>
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: [PATCH] l2cr fix for BootX
Message-Id: <19981223050355.013934@mail.mipsys.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--==_Boundary-1_==
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Enclosed is a patch to pmac_setup.c and setup.c that

 - removes the relics of the old l2cr=xxxx kernel arg. in setup.c
 - adds code for getting the "l2cr-value" property, currently at the root
of "cpus" node (that's where bootx puts it but this could eventually be
changed since no one uses it yet).

I did put the code in pmad_setup.c to avoid breaking anything on other
arch, you may want to move it to ppc common code since you know it better
than me and you may want to remove the global (i was not sure, I did put
them to allow other processors to read the value too but I don't think
there is any MP G3 available anyway).

With this fix and the latest bootx, G3 upgrade card vendors will be able
to set a preference in BootX prefs file with the L2CR value from their
proprietary MacOS software (PowerLogix is expected to do it soon).
There'll be soon a generic tool for "capturing" the l2cr value under
MacOS and set the appropriate resource in BootX too.

-- 
           E-Mail: <mailto:bh40@calva.net>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>



--==_Boundary-1_==
Mime-Version: 1.0
Content-Type: application/octet-stream; name="l2cr.patch.tgz"; x-mac-creator="554e4958"; x-mac-type="42494e41"
Message-Id: <19981223050408.004153>
Date: Wed, 23 Dec 1998 05:04:08 +0100
Content-Transfer-Encoding: base64

H4sICDuEgDYAA2wyY3IucGF0Y2gudGFyAO1WaW/bRhD1V/JXTBm44Gnx0GUJTow6
TRDElQujF9AUC5pcSYTJJcFDkBH4v3d2STuSbMVpAbsosA8SKS1nZ+dYvrcVrZvi
qAjraHnwXPBcd9jvwwGANxp4/I5wuzsOBkEfYDjsu57rBX0fR/jtANxni2gDTVWH
JcDBFWVfrUCZ5/VLxPPCcBwH0oQ166O8TBa9sIyWvaKIete0ZDTtVWJ7RMovywbe
0gg8F1xv4vcn/hi84+OxallWNz+mq73Tf6exmO4H4PoTz50Eo3b66Sk4w+OR7Y3B
4vchnJ6qoJQ4r2TgTlW4VUF1eiacLWl0XYGW+lF5skZoEOVZFrLYwfUp5EWd5AzM
nuqs8iQGjIKI5QmfoUdL7LJZ1aUNCavBxEtlqM5n1VGSOeigkwWtyc+/XeoGvH4N
3tCAkxMYo4nCbZSGVcmCYRppzhawClM4gSrJipQSdFrnTaoL57Nfz89tcI0pn1SU
uMy1/vHHyxn5MHt30UYPGBbUORym609Ms7mz1pzHS879s0vd3R24s7lVHfyoQEjC
knresEgX2baZ8vJ3mZpRFvO6kMLGem5Hb0JGs7y8IXzr12gBe55TFpPCMFT4LBo1
8gfYIGvkBfZI9EmFV8k8pnM4u5i9+/Ce/PHTxQxXo+sa2w8isHWWM5KFBamiNlRM
w3pgwWvXRDUUNSnpogKTrqMCLUHZmi9GeLvQHD865kh4kjZo3E7joSpiiqjgf/1u
/R9QZGH3njyfCDzB//4gGNzzvzfE354fDDzJ/y+BJ/h/Y3ugCDQUZvlKiACyuDcJ
ht8iAls+NpUAhWQ4CdwvSjAQ/ILXsaCXVwmL0iamoNVJRo+WGmece6oSPBeXyYoi
F85zpBVO7Jz28xUtyySmgvmRp919zwjSakOn3G3HSMJpFa5oTDp1EQTz51/ciIfo
BT6PEQ8otteJFZIy8C/y2o5OOcK/BkWZF7Ssb1B6oF5SQI5LkL9uuFpZCiswxnmC
S2H1kohWuhYVTaUZU0XBx5zv0OQ7zMNAIrY2tEgoWZekvj1qcEOFa9rd4ujE3gqr
FSvBx2IR4WhjGSWlDCyUOSFjc/2qmc9paeFo5wfuivmpnoC7PmzlTATUer3FC/9+
UXSc3Gk6L6bvubyYvu/b/p2iKOa2OGFqYgOJAl3hagsskLkrYOaWYk3/fTO+fhiw
FFGZTq3adhGW4xY1n+jiI238B3389kY+3knlsdfCm+551r4WaCFi6qy2Dyc7Q3tc
dIa3G3uhK/GDCSLPh+cl7v1+mzHQ+S4zbLgKsa04AlEYYQuTCg4rvvnEcnuCsR9Z
tcv0e9y9Y7dFV/A3oFEWXqU01mACWpxU7R+eEm7SOQ1xP1NxChPHkt2j0Mf3b3+Q
BxAJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCQmJl8bfRctRUQAoAAA=

--==_Boundary-1_==--



[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
